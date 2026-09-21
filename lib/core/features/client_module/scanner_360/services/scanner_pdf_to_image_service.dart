import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_pdfviewer_platform_interface/pdfviewer_platform_interface.dart';

/// Raised when a PDF → images conversion fails.
class ScannerPdfToImageException implements Exception {
  const ScannerPdfToImageException(this.message);

  final String message;

  @override
  String toString() => 'ScannerPdfToImageException: $message';
}

/// Output image format.
enum ScannerPdfToImageFormat {
  png,
  jpeg,
}

/// Result of a completed conversion.
class ScannerPdfToImageResult {
  const ScannerPdfToImageResult({
    required this.outputDirectory,
    required this.imagePaths,
    required this.zipPath,
  });

  /// Directory containing the generated images and the ZIP.
  final String outputDirectory;

  /// Absolute paths of the generated image files, in page order.
  final List<String> imagePaths;

  /// Absolute path of the ZIP archive containing every image.
  final String zipPath;
}

/// Converts PDF pages into image files.
///
/// This service is standalone. It has no knowledge of the Scanner 360
/// document model, sessions, storage, repositories, orchestrator,
/// OCR, providers, or the scanner library.
///
/// Phase 10D.2 scope:
///  - Syncfusion PDF Viewer rendering
///  - PNG / JPEG output
///  - 72 / 150 / 300 DPI
///  - sequential page processing
///  - individual images + one ZIP
///  - temporary output directory
class ScannerPdfToImageService {
  const ScannerPdfToImageService();

  /// Converts the PDF at [pdfPath].
  ///
  /// [pages] is a 1-based, ascending list of page numbers to render.
  /// [format] selects PNG or JPEG.
  /// [dpi] must be 72, 150, or 300.
  ///
  /// The generated files are written to a new unique subdirectory of
  /// the system temporary directory.
  Future<ScannerPdfToImageResult> convert({
    required String pdfPath,
    required List<int> pages,
    required ScannerPdfToImageFormat format,
    required int dpi,
  }) async {
    if (pages.isEmpty) {
      throw const ScannerPdfToImageException(
        'No pages were selected for conversion.',
      );
    }
    if (dpi != 72 && dpi != 150 && dpi != 300) {
      throw ScannerPdfToImageException(
        'Unsupported DPI: $dpi. Use 72, 150, or 300.',
      );
    }

    final pdfFile = File(pdfPath);
    if (!await pdfFile.exists()) {
      throw ScannerPdfToImageException(
        'PDF file not found: $pdfPath',
      );
    }

    final Uint8List pdfBytes;
    try {
      pdfBytes = await pdfFile.readAsBytes();
    } catch (e) {
      throw ScannerPdfToImageException(
        'Failed to read PDF file: $e',
      );
    }

    final outputDir = await _createOutputDirectory();

    final documentId = 's360_pdf_${DateTime.now().microsecondsSinceEpoch}';
    final platform = PdfViewerPlatform.instance;

    var rendererInitialized = false;

    try {
      final String? initResult;
      try {
        initResult = await platform.initializePdfRenderer(
          pdfBytes,
          documentId,
        );
      } catch (e) {
        throw ScannerPdfToImageException(
          'Failed to initialize PDF renderer: $e',
        );
      }

      if (initResult == null) {
        throw const ScannerPdfToImageException(
          'Failed to initialize PDF renderer.',
        );
      }

      rendererInitialized = true;

      final List<dynamic>? widths = await platform.getPagesWidth(documentId);
      final List<dynamic>? heights = await platform.getPagesHeight(documentId);

      if (widths == null || heights == null || widths.isEmpty) {
        throw const ScannerPdfToImageException(
          'Unable to read PDF page dimensions.',
        );
      }

      final totalPages = widths.length;

      for (final pageNumber in pages) {
        if (pageNumber < 1 || pageNumber > totalPages) {
          throw ScannerPdfToImageException(
            'Page $pageNumber is out of range (1..$totalPages).',
          );
        }
      }

      final imagePaths = <String>[];

      for (final pageNumber in pages) {
        final widthPoints = _toDouble(widths[pageNumber - 1]);
        final heightPoints = _toDouble(heights[pageNumber - 1]);

        if (widthPoints <= 0 || heightPoints <= 0) {
          throw ScannerPdfToImageException(
            'Invalid page dimensions for page $pageNumber.',
          );
        }

        final pixelWidth = (widthPoints / 72.0 * dpi).round();
        final pixelHeight = (heightPoints / 72.0 * dpi).round();

        if (pixelWidth <= 0 || pixelHeight <= 0) {
          throw ScannerPdfToImageException(
            'Computed invalid raster dimensions for page $pageNumber.',
          );
        }

        final Uint8List? rgbaBytes;
        try {
          rgbaBytes = await platform.getPage(
            pageNumber,
            pixelWidth,
            pixelHeight,
            documentId,
          );
        } catch (e) {
          throw ScannerPdfToImageException(
            'Failed to render page $pageNumber: $e',
          );
        }

        if (rgbaBytes == null) {
          throw ScannerPdfToImageException(
            'Renderer returned no data for page $pageNumber.',
          );
        }

        final expectedLength = pixelWidth * pixelHeight * 4;
        if (rgbaBytes.length < expectedLength) {
          throw ScannerPdfToImageException(
            'Renderer returned an unexpected buffer size for page '
            '$pageNumber (got ${rgbaBytes.length}, expected $expectedLength).',
          );
        }

        final image = img.Image.fromBytes(
          width: pixelWidth,
          height: pixelHeight,
          bytes: rgbaBytes.buffer,
          numChannels: 4,
        );

        final List<int> encoded;
        final String extension;
        switch (format) {
          case ScannerPdfToImageFormat.png:
            encoded = img.encodePng(image);
            extension = 'png';
            break;
          case ScannerPdfToImageFormat.jpeg:
            encoded = img.encodeJpg(image, quality: 92);
            extension = 'jpg';
            break;
        }

        final fileName = _fileNameFor(pageNumber, totalPages, extension);
        final filePath = '${outputDir.path}${Platform.pathSeparator}$fileName';

        try {
          await File(filePath).writeAsBytes(encoded, flush: true);
        } catch (e) {
          throw ScannerPdfToImageException(
            'Failed to write page $pageNumber to disk: $e',
          );
        }

        imagePaths.add(filePath);
      }

      final zipPath = await _writeZip(
        outputDir: outputDir,
        imagePaths: imagePaths,
      );

      return ScannerPdfToImageResult(
        outputDirectory: outputDir.path,
        imagePaths: List.unmodifiable(imagePaths),
        zipPath: zipPath,
      );
    } finally {
      if (rendererInitialized) {
        try {
          await platform.closeDocument(documentId);
        } catch (_) {
          // Ignore close failures; the conversion result is already
          // either returned or the original exception is propagating.
        }
      }
    }
  }

  // ------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------

  Future<Directory> _createOutputDirectory() async {
    final temp = await getTemporaryDirectory();
    final stamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '')
        .replaceAll('-', '')
        .replaceAll('.', '');
    final dir = Directory(
      '${temp.path}${Platform.pathSeparator}'
      'scanner_360_pdf_to_images_$stamp',
    );
    try {
      await dir.create(recursive: true);
    } catch (e) {
      throw ScannerPdfToImageException(
        'Failed to create output directory: $e',
      );
    }
    return dir;
  }

  String _fileNameFor(int pageNumber, int totalPages, String extension) {
    final digits = totalPages >= 1000 ? 4 : 3;
    final padded = pageNumber.toString().padLeft(digits, '0');
    return 'page_$padded.$extension';
  }

  Future<String> _writeZip({
    required Directory outputDir,
    required List<String> imagePaths,
  }) async {
    final archive = Archive();
    for (final path in imagePaths) {
      final file = File(path);
      final bytes = await file.readAsBytes();
      final name = path.split(Platform.pathSeparator).last;
      archive.addFile(ArchiveFile(name, bytes.length, bytes));
    }

    final zipPath =
        '${outputDir.path}${Platform.pathSeparator}converted_pages.zip';

    try {
      final zipped = ZipEncoder().encode(archive);
      await File(zipPath).writeAsBytes(zipped, flush: true);
    } catch (e) {
      throw ScannerPdfToImageException(
        'Failed to create ZIP archive: $e',
      );
    }

    return zipPath;
  }

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/ocr_result.dart';
import '../models/scanner_language.dart';
import 'scanner_ocr_service.dart';
import 'scanner_pdf_to_image_service.dart';

/// Raised when a searchable-PDF conversion fails.
class ScannerSearchablePdfException implements Exception {
  const ScannerSearchablePdfException(this.message);

  final String message;

  @override
  String toString() => 'ScannerSearchablePdfException: $message';
}

/// Result of a completed searchable-PDF conversion.
class ScannerSearchablePdfResult {
  const ScannerSearchablePdfResult({
    required this.outputPath,
    required this.pageCount,
  });

  /// Absolute path of the generated searchable PDF.
  final String outputPath;

  /// Number of pages in the generated PDF.
  final int pageCount;
}

/// Builds a searchable PDF from an arbitrary input PDF.
///
/// Pipeline:
///   1. Render each source page to a temp image via
///      [ScannerPdfToImageService].
///   2. OCR each rendered image via [ScannerOcrService].
///   3. Build a new PDF where each page contains the rendered
///      image as a full-page background and the OCR words as
///      invisible selectable text at the correct positions.
///
/// This service is standalone. It has no knowledge of the Scanner
/// 360 document model, sessions, storage, repositories, or
/// orchestrator. Its output is a conversion artifact.
class ScannerSearchablePdfService {
  const ScannerSearchablePdfService();

  /// Fixed DPI for the render/OCR/overlay pipeline.
  static const int _dpi = 150;

  /// Converts the PDF at [sourcePdfPath] into a searchable PDF.
  ///
  /// Throws [ScannerSearchablePdfException] on any failure.
  Future<ScannerSearchablePdfResult> convert({
    required String sourcePdfPath,
  }) async {
    final sourceFile = File(sourcePdfPath);
    if (!await sourceFile.exists()) {
      throw ScannerSearchablePdfException(
        'PDF file not found: $sourcePdfPath',
      );
    }

    // 1. Render every page to an image using 10D.2's service.
    final renderResult = await _renderAllPages(sourcePdfPath);
    final imagePaths = renderResult.imagePaths;
    final totalPages = imagePaths.length;

    if (totalPages == 0) {
      throw const ScannerSearchablePdfException(
        'The PDF contains no pages.',
      );
    }

    // 2. Build the new PDF sequentially.
    final doc = pw.Document();

    for (var i = 0; i < totalPages; i++) {
      final imagePath = imagePaths[i];
      final imageFile = File(imagePath);
      if (!await imageFile.exists()) {
        throw ScannerSearchablePdfException(
          'Rendered image missing for page ${i + 1}: $imagePath',
        );
      }

      final Uint8List imageBytes;
      try {
        imageBytes = await imageFile.readAsBytes();
      } catch (e) {
        throw ScannerSearchablePdfException(
          'Failed to read rendered page ${i + 1}: $e',
        );
      }

      // Read pixel dimensions via package:image. pw.MemoryImage
      // does not expose reliable pixel dimensions.
      final decoded = img.decodeImage(imageBytes);
      if (decoded == null) {
        throw ScannerSearchablePdfException(
          'Failed to decode rendered page ${i + 1}.',
        );
      }
      final imageWidthPx = decoded.width.toDouble();
      final imageHeightPx = decoded.height.toDouble();

      final image = pw.MemoryImage(imageBytes);

      // 3. OCR the rendered image.
      final OcrResult ocrResult;
      try {
        ocrResult = await const ScannerOcrService().extractText(
          imagePath: imagePath,
          language: ScannerLanguage.latin,
        );
      } catch (e) {
        throw ScannerSearchablePdfException(
          'OCR failed on page ${i + 1}: $e',
        );
      }

      // 4. Build the PDF page.
      doc.addPage(
        _buildPage(
          image: image,
          imageWidthPx: imageWidthPx,
          imageHeightPx: imageHeightPx,
          ocrResult: ocrResult,
        ),
      );
    }

    // 5. Save to a temporary output path.
    final outputPath = await _newOutputPdfPath();
    final outputFile = File(outputPath);
    try {
      final saved = await doc.save();
      await outputFile.writeAsBytes(saved, flush: true);
    } catch (e) {
      throw ScannerSearchablePdfException(
        'Failed to write searchable PDF: $e',
      );
    }

    return ScannerSearchablePdfResult(
      outputPath: outputPath,
      pageCount: totalPages,
    );
  }

  // ------------------------------------------------------------
  // Rendering
  // ------------------------------------------------------------

  Future<ScannerPdfToImageResult> _renderAllPages(
    String sourcePdfPath,
  ) async {
    try {
      // Empty pages list means "all pages" for
      // ScannerPdfToImageService (established by 10D.2).
      return await const ScannerPdfToImageService().convert(
        pdfPath: sourcePdfPath,
        pages: const <int>[],
        format: ScannerPdfToImageFormat.png,
        dpi: _dpi,
      );
    } on ScannerPdfToImageException catch (e) {
      throw ScannerSearchablePdfException(
        'Failed to render PDF pages: ${e.message}',
      );
    } catch (e) {
      throw ScannerSearchablePdfException(
        'Failed to render PDF pages: $e',
      );
    }
  }

  // ------------------------------------------------------------
  // Page construction
  // ------------------------------------------------------------

  pw.Page _buildPage({
    required pw.MemoryImage image,
    required double imageWidthPx,
    required double imageHeightPx,
    required OcrResult ocrResult,
  }) {
    // The rendered image's pixel dimensions are used to derive
    // the PDF page size in points at the fixed DPI.
    final pageWidthPt = imageWidthPx * 72.0 / _dpi;
    final pageHeightPt = imageHeightPx * 72.0 / _dpi;

    final pageFormat = PdfPageFormat(pageWidthPt, pageHeightPt);

    final wordWidgets = _buildWordOverlays(
      ocrResult: ocrResult,
      imageWidthPx: imageWidthPx,
      imageHeightPx: imageHeightPx,
      pageWidthPt: pageWidthPt,
      pageHeightPt: pageHeightPt,
    );

    return pw.Page(
      pageFormat: pageFormat,
      build: (context) => pw.Stack(
        children: [
          pw.Positioned(
            left: 0,
            top: 0,
            child: pw.Image(
              image,
              fit: pw.BoxFit.fill,
              width: pageWidthPt,
              height: pageHeightPt,
            ),
          ),
          ...wordWidgets,
        ],
      ),
    );
  }

  List<pw.Widget> _buildWordOverlays({
    required OcrResult ocrResult,
    required double imageWidthPx,
    required double imageHeightPx,
    required double pageWidthPt,
    required double pageHeightPt,
  }) {
    final scaleX = pageWidthPt / imageWidthPx;
    final scaleY = pageHeightPt / imageHeightPx;

    final widgets = <pw.Widget>[];

    for (final block in ocrResult.blocks) {
      for (final line in block.lines) {
        for (final word in line.words) {
          final text = word.text;
          if (text.trim().isEmpty) continue;

          final leftPx = word.boundingBox.left;
          final topPx = word.boundingBox.top;
          final widthPx = word.boundingBox.width;
          final heightPx = word.boundingBox.height;

          if (widthPx <= 0 || heightPx <= 0) continue;

          final leftPt = leftPx * scaleX;
          final topPt = topPx * scaleY;
          final widthPt = widthPx * scaleX;
          final heightPt = heightPx * scaleY;

          if (widthPt <= 0 || heightPt <= 0) continue;

          widgets.add(
            pw.Positioned(
              left: leftPt,
              top: topPt,
              child: pw.SizedBox(
                width: widthPt,
                height: heightPt,
                child: pw.Text(
                  text,
                  style: pw.TextStyle(
                    fontSize: heightPt,
                    renderingMode: PdfTextRenderingMode.invisible,
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return widgets;
  }

  // ------------------------------------------------------------
  // Output path
  // ------------------------------------------------------------

  Future<String> _newOutputPdfPath() async {
    final tempDir = Directory.systemTemp;
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final dir = Directory(
      '${tempDir.path}${Platform.pathSeparator}'
      'scanner_360_searchable_pdf_$stamp',
    );
    try {
      await dir.create(recursive: true);
    } catch (e) {
      throw ScannerSearchablePdfException(
        'Failed to prepare output directory: $e',
      );
    }
    return '${dir.path}${Platform.pathSeparator}searchable.pdf';
  }
}
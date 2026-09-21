import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

import '../constants/scanner_constants.dart';

/// Raised when arbitrary image files cannot be converted to PDF.
class ScannerImageToPdfException implements Exception {
  const ScannerImageToPdfException(this.message);

  final String message;

  @override
  String toString() => 'ScannerImageToPdfException: $message';
}

/// Converts a list of arbitrary image files into a single PDF.
///
/// This service is intentionally standalone. It is not aware of
/// [ScannerPage], [ScannerDocument], scanner sessions, the scanner
/// storage index, OCR, or any other scanner-specific concept.
///
/// Phase 10D.1 scope:
///  - fixed A4 pages
///  - source aspect ratio preserved via [pw.BoxFit.contain]
///  - image centered on each page
///  - one PDF page per input image
///  - output written to the caller-supplied path
class ScannerImageToPdfService {
  const ScannerImageToPdfService();

  /// Generates a PDF at [outputPath] with one A4 page per entry in
  /// [imagePaths], in the order supplied.
  ///
  /// Returns the resolved output path. Throws
  /// [ScannerImageToPdfException] on any failure.
  Future<String> convert({
    required List<String> imagePaths,
    required String outputPath,
  }) async {
    if (imagePaths.isEmpty) {
      throw const ScannerImageToPdfException(
        'No images were supplied for conversion.',
      );
    }

    if (outputPath.trim().isEmpty) {
      throw const ScannerImageToPdfException(
        'An output path is required.',
      );
    }

    final doc = pw.Document();

    final pageFormat = ScannerConstants.defaultPdfPageFormat;

    for (var i = 0; i < imagePaths.length; i++) {
      final imagePath = imagePaths[i];

      final file = File(imagePath);
      if (!await file.exists()) {
        throw ScannerImageToPdfException(
          'Image file not found: $imagePath',
        );
      }

      final bytes = await file.readAsBytes();
      final pw.MemoryImage image;
      try {
        image = pw.MemoryImage(bytes);
      } catch (e) {
        throw ScannerImageToPdfException(
          'Unsupported or corrupt image at index $i '
          '($imagePath): $e',
        );
      }

      doc.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (context) => pw.Center(
            child: pw.Image(
              image,
              fit: pw.BoxFit.contain,
            ),
          ),
        ),
      );
    }

    final outFile = File(outputPath);
    try {
      await outFile.parent.create(recursive: true);
    } catch (e) {
      throw ScannerImageToPdfException(
        'Failed to prepare output directory: $e',
      );
    }

    try {
      final saved = await doc.save();
      await outFile.writeAsBytes(saved, flush: true);
    } catch (e) {
      throw ScannerImageToPdfException(
        'Failed to write the PDF: $e',
      );
    }

    return outputPath;
  }
}
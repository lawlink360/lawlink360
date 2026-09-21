import 'dart:io';
import 'dart:typed_data';

import 'package:syncfusion_flutter_pdf/pdf.dart';

/// Raised when a PDF → text extraction fails.
class ScannerPdfToTextException implements Exception {
  const ScannerPdfToTextException(this.message);

  final String message;

  @override
  String toString() => 'ScannerPdfToTextException: $message';
}

/// Result of a completed PDF text extraction.
class ScannerPdfToTextResult {
  const ScannerPdfToTextResult({
    required this.text,
    required this.pageCount,
  });

  /// The extracted text, with page boundaries preserved as newlines.
  final String text;

  /// Number of pages in the source PDF.
  final int pageCount;

  /// Whether the extraction produced any non-whitespace text.
  bool get hasText => text.trim().isNotEmpty;
}

/// Extracts the embedded text layer from a PDF.
///
/// This service is standalone. It has no knowledge of the Scanner 360
/// document model, sessions, storage, repositories, orchestrator,
/// OCR, providers, or the scanner library.
///
/// Phase 10D.3 scope:
///  - Syncfusion PDF text extraction
///  - single string result with page count
///  - typed exception on failure
///  - no OCR fallback
class ScannerPdfToTextService {
  const ScannerPdfToTextService();

  /// Extracts text from the PDF at [pdfPath].
  ///
  /// Throws [ScannerPdfToTextException] on any failure.
  ///
  /// Returns a result whose [ScannerPdfToTextResult.text] may be
  /// empty if the PDF has no embedded text layer. That case is not
  /// treated as a failure; the caller is expected to show a
  /// "no extractable text" state.
  Future<ScannerPdfToTextResult> extract({required String pdfPath}) async {
    final file = File(pdfPath);
    if (!await file.exists()) {
      throw ScannerPdfToTextException(
        'PDF file not found: $pdfPath',
      );
    }

    final Uint8List pdfBytes;
    try {
      pdfBytes = await file.readAsBytes();
    } catch (e) {
      throw ScannerPdfToTextException(
        'Failed to read PDF file: $e',
      );
    }

    PdfDocument? document;
    try {
      try {
        document = PdfDocument(inputBytes: pdfBytes);
      } catch (e) {
        final message = e.toString();
        if (message.toLowerCase().contains('password') ||
            message.toLowerCase().contains('encrypt')) {
          throw const ScannerPdfToTextException(
            'This PDF is password-protected and cannot be read.',
          );
        }
        throw ScannerPdfToTextException(
          'Failed to open PDF: $e',
        );
      }

      final pageCount = document.pages.count;
      if (pageCount <= 0) {
        throw const ScannerPdfToTextException(
          'The PDF contains no pages.',
        );
      }

      final String text;
      try {
        text = PdfTextExtractor(document).extractText();
      } catch (e) {
        throw ScannerPdfToTextException(
          'Failed to extract text from PDF: $e',
        );
      }

      return ScannerPdfToTextResult(
        text: text,
        pageCount: pageCount,
      );
    } finally {
      try {
        document?.dispose();
      } catch (_) {
        // Ignore disposal failures; the extraction result is
        // already returned or the original exception is propagating.
      }
    }
  }
}
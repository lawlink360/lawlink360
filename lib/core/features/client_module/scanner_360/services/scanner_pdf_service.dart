import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants/scanner_constants.dart';
import '../models/document_metadata.dart';
import '../models/ocr_result.dart';
import '../models/pdf_document.dart' as scanner_model;
import '../models/scanner_page.dart';

class ScannerPdfException implements Exception {
  const ScannerPdfException(this.message);

  final String message;

  @override
  String toString() => 'ScannerPdfException: $message';
}

class ScannerPdfService {
  const ScannerPdfService();

  /// Builds the PDF for [pages].
  ///
  /// When [ocrResults] is null, an image-only PDF is produced and
  /// [scanner_model.PdfDocument.isSearchable] is false.
  ///
  /// When [ocrResults] is supplied, an invisible per-word text
  /// layer is added on top of each page image and
  /// [scanner_model.PdfDocument.isSearchable] is true.
  ///
  /// [ocrResults] must be index-aligned with [pages]. A length
  /// mismatch causes a [ScannerPdfException], so a partially
  /// searchable document can never be produced.
  Future<scanner_model.PdfDocument> buildPdf({
    required List<ScannerPage> pages,
    required DocumentMetadata metadata,
    required String outputPath,
    List<OcrResult>? ocrResults,
  }) async {
    if (pages.isEmpty) {
      throw const ScannerPdfException(
        'Cannot create a PDF with zero pages.',
      );
    }

    final isSearchable = ocrResults != null;

    if (isSearchable && ocrResults.length != pages.length) {
      throw ScannerPdfException(
        'OCR results count (${ocrResults.length}) does not match '
        'page count (${pages.length}).',
      );
    }

    final doc = pw.Document(
      title: metadata.name,
    );

    final pageFormat = ScannerConstants.defaultPdfPageFormat;

    for (var i = 0; i < pages.length; i++) {
      final page = pages[i];
      final file = File(page.imagePath);

      if (!await file.exists()) {
        throw ScannerPdfException(
          'Page image missing: ${page.imagePath}',
        );
      }

      final bytes = await file.readAsBytes();
      final image = pw.MemoryImage(bytes);

      if (isSearchable) {
        doc.addPage(
          pw.Page(
            pageFormat: pageFormat,
            build: (context) => _buildSearchablePage(
              image: image,
              ocrResult: ocrResults[i],
              page: page,
              pageFormat: pageFormat,
            ),
          ),
        );
      } else {
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
    }

    final outFile = File(outputPath);

    await outFile.parent.create(recursive: true);

    final saved = await doc.save();

    await outFile.writeAsBytes(
      saved,
      flush: true,
    );

    final stat = await outFile.stat();

    return scanner_model.PdfDocument(
      id: metadata.id,
      filePath: outputPath,
      pageCount: pages.length,
      sizeInBytes: stat.size,
      createdAt: DateTime.now(),
      isSearchable: isSearchable,
    );
  }

  // ============================================================
  // Searchable page
  // ============================================================

  pw.Widget _buildSearchablePage({
    required pw.MemoryImage image,
    required OcrResult ocrResult,
    required ScannerPage page,
    required PdfPageFormat pageFormat,
  }) {
    final pageWidthPt = pageFormat.width;
    final pageHeightPt = pageFormat.height;

    final imageWidthPx = page.width.toDouble();
    final imageHeightPx = page.height.toDouble();

    final scale = _containScale(
      pageWidthPt: pageWidthPt,
      pageHeightPt: pageHeightPt,
      imageWidthPx: imageWidthPx,
      imageHeightPx: imageHeightPx,
    );

    final renderedWidthPt = imageWidthPx * scale;
    final renderedHeightPt = imageHeightPx * scale;

    final offsetX = (pageWidthPt - renderedWidthPt) / 2;
    final offsetY = (pageHeightPt - renderedHeightPt) / 2;

    final wordWidgets = <pw.Widget>[];
    for (final block in ocrResult.blocks) {
      for (final line in block.lines) {
        for (final word in line.words) {
          final text = word.text;
          if (text.isEmpty) continue;

          final left = offsetX + word.boundingBox.left * scale;
          final top = offsetY + word.boundingBox.top * scale;
          final width = word.boundingBox.width * scale;
          final height = word.boundingBox.height * scale;

          if (width <= 0 || height <= 0) continue;

          wordWidgets.add(
            pw.Positioned(
              left: left,
              top: top,
              child: pw.SizedBox(
                width: width,
                height: height,
                child: pw.Text(
                  text,
                  style: pw.TextStyle(
                    fontSize: height,
                    renderingMode: PdfTextRenderingMode.invisible,
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return pw.Stack(
      children: [
        pw.Positioned(
          left: 0,
          top: 0,
          child: pw.Image(
            image,
            fit: pw.BoxFit.contain,
            width: pageWidthPt,
            height: pageHeightPt,
          ),
        ),
        ...wordWidgets,
      ],
    );
  }

  double _containScale({
    required double pageWidthPt,
    required double pageHeightPt,
    required double imageWidthPx,
    required double imageHeightPx,
  }) {
    if (imageWidthPx <= 0 || imageHeightPx <= 0) {
      throw const ScannerPdfException(
        'Invalid image dimensions for PDF scaling.',
      );
    }
    final scaleX = pageWidthPt / imageWidthPx;
    final scaleY = pageHeightPt / imageHeightPx;
    return scaleX < scaleY ? scaleX : scaleY;
  }
}
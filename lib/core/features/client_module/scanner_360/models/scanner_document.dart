import 'package:meta/meta.dart';

import 'document_metadata.dart';
import 'ocr_result.dart';
import 'pdf_document.dart';
import 'scanner_export_format.dart';
import 'scanner_page.dart';

@immutable
class ScannerDocument {
  const ScannerDocument({
    required this.id,
    required this.metadata,
    required this.pages,
    required this.exportFormat,
    this.ocrResult,
    this.pdfDocument,
  });

  final String id;
  final DocumentMetadata metadata;
  final List<ScannerPage> pages;
  final OcrResult? ocrResult;
  final PdfDocument? pdfDocument;
  final ScannerExportFormat exportFormat;

  ScannerDocument copyWith({
    String? id,
    DocumentMetadata? metadata,
    List<ScannerPage>? pages,
    OcrResult? ocrResult,
    bool clearOcrResult = false,
    PdfDocument? pdfDocument,
    bool clearPdfDocument = false,
    ScannerExportFormat? exportFormat,
  }) {
    return ScannerDocument(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      pages: pages ?? this.pages,
      ocrResult: clearOcrResult ? null : (ocrResult ?? this.ocrResult),
      pdfDocument: clearPdfDocument ? null : (pdfDocument ?? this.pdfDocument),
      exportFormat: exportFormat ?? this.exportFormat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'metadata': metadata.toMap(),
      'pages': pages.map((p) => p.toMap()).toList(),
      'ocrResult': ocrResult?.toMap(),
      'pdfDocument': pdfDocument?.toMap(),
      'exportFormat': exportFormat.name,
    };
  }

  factory ScannerDocument.fromMap(Map<String, dynamic> map) {
    return ScannerDocument(
      id: map['id'] as String,
      metadata: DocumentMetadata.fromMap(
        (map['metadata'] as Map).cast<String, dynamic>(),
      ),
      pages: (map['pages'] as List)
          .map((e) => ScannerPage.fromMap((e as Map).cast<String, dynamic>()))
          .toList(),
      ocrResult: map['ocrResult'] == null
          ? null
          : OcrResult.fromMap((map['ocrResult'] as Map).cast<String, dynamic>()),
      pdfDocument: map['pdfDocument'] == null
          ? null
          : PdfDocument.fromMap(
              (map['pdfDocument'] as Map).cast<String, dynamic>(),
            ),
      exportFormat: ScannerExportFormat.values.firstWhere(
        (e) => e.name == map['exportFormat'],
        orElse: () => ScannerExportFormat.pdf,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScannerDocument &&
        other.id == id &&
        other.metadata == metadata &&
        _listEquals(other.pages, pages) &&
        other.ocrResult == ocrResult &&
        other.pdfDocument == pdfDocument &&
        other.exportFormat == exportFormat;
  }

  @override
  int get hashCode => Object.hash(
        id,
        metadata,
        Object.hashAll(pages),
        ocrResult,
        pdfDocument,
        exportFormat,
      );
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
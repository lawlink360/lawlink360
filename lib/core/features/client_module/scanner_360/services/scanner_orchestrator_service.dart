import 'dart:io';

import 'package:image/image.dart' as img;

import '../models/crop_data.dart';
import '../models/document_metadata.dart';
import '../models/ocr_result.dart';
import '../models/pdf_document.dart';
import '../models/scan_filter.dart';
import '../models/scan_settings.dart';
import '../models/scanner_document.dart';
import '../models/scanner_document_category.dart';
import '../models/scanner_export_format.dart';
import '../models/scanner_language.dart';
import '../models/scanner_page.dart';
import '../models/scanner_session.dart';
import '../utils/scanner_file_utils.dart';
import '../utils/scanner_naming_utils.dart';
import 'scanner_image_processing_service.dart';
import 'scanner_ocr_service.dart';
import 'scanner_pdf_service.dart';
import 'scanner_storage_service.dart';

/// Raised when an orchestrated operation fails.
class ScannerOrchestratorException implements Exception {
  const ScannerOrchestratorException(this.message);
  final String message;

  @override
  String toString() => 'ScannerOrchestratorException: $message';
}

/// Composes the Scanner 360 services for end-to-end operations.
///
/// This class holds no state. Every method takes exactly what it
/// needs and returns exactly what it produces.
class ScannerOrchestratorService {
  ScannerOrchestratorService({
    ScannerImageProcessingService? imageProcessing,
    ScannerOcrService? ocr,
    ScannerPdfService? pdf,
    ScannerStorageService? storage,
  })  : _imageProcessing =
            imageProcessing ?? const ScannerImageProcessingService(),
        _ocr = ocr ?? const ScannerOcrService(),
        _pdf = pdf ?? const ScannerPdfService(),
        _storage = storage ?? const ScannerStorageService();

  final ScannerImageProcessingService _imageProcessing;
  final ScannerOcrService _ocr;
  final ScannerPdfService _pdf;
  final ScannerStorageService _storage;

  // ============================================================
  // Page processing pipeline
  // ============================================================

  /// Processes a captured file into a session-owned [ScannerPage].
  ///
  /// Phase 9 Batch 9.5 — the page image is now written under
  /// `scanner_360/sessions/<sessionId>/pages/page_<pageId>.jpg`.
  /// Derived files (filter / rotate / rectify) remain siblings of
  /// the session-owned target path, so they stay inside the same
  /// session directory.
  ///
  /// The Batch 9.2 export / adoption / persistence pipeline is
  /// unaffected. Adoption copies from [ScannerPage.imagePath]
  /// regardless of the folder it lives in.
  Future<ScannerPage> processCapturedPage({
    required String sessionId,
    required String capturedFilePath,
    required String pageId,
    required ScanSettings settings,
    CropData? cropData,
    double rotationDegrees = 0.0,
  }) async {
    await _storage.ensureReady();

    await ScannerFileUtils.ensureSessionDirectories(sessionId);

    final targetPath =
        await ScannerFileUtils.buildSessionPagePath(sessionId, pageId);

    var currentPath = await _copyTo(capturedFilePath, targetPath);

    if (cropData != null) {
      final rectifiedPath = '${targetPath}_rect.jpg';
      currentPath = await _imageProcessing.rectifyPerspective(
        inputPath: currentPath,
        outputPath: rectifiedPath,
        cropData: cropData,
      );
    }

    if (settings.defaultFilter != ScanFilter.original) {
      final filteredPath = '${targetPath}_filter.jpg';
      currentPath = await _imageProcessing.applyFilter(
        inputPath: currentPath,
        outputPath: filteredPath,
        filter: settings.defaultFilter,
      );
    }

    if (rotationDegrees != 0.0) {
      final rotatedPath = '${targetPath}_rot.jpg';
      currentPath = await _imageProcessing.rotate(
        inputPath: currentPath,
        outputPath: rotatedPath,
        degrees: rotationDegrees,
      );
    }

    final size = await _readImageSize(currentPath);

    return ScannerPage(
      id: pageId,
      imagePath: currentPath,
      thumbnailPath: null,
      cropData: cropData,
      filter: settings.defaultFilter,
      rotation: rotationDegrees,
      width: size.width,
      height: size.height,
      ocrResult: null,
      createdAt: DateTime.now(),
    );
  }

  // ============================================================
  // OCR
  // ============================================================

  Future<ScannerPage> runOcrOnPage({
    required ScannerPage page,
    required ScannerLanguage language,
  }) async {
    final result = await _ocr.extractText(
      imagePath: page.imagePath,
      language: language,
      pageId: page.id,
    );
    return page.copyWith(ocrResult: result);
  }

  // ============================================================
  // Export
  // ============================================================

  /// Builds the PDF for [session] if the export format requires
  /// it, persists the document through storage, and returns the
  /// resulting [ScannerDocument].
  ///
  /// [documentId] must be supplied by the caller so the same id
  /// can be used by the caller's session state.
  ///
  /// When [category] is not supplied, defaults to
  /// [ScannerDocumentCategory.other].
  ///
  /// When [nameOverride] is not supplied, derives a default name
  /// through [ScannerNamingUtils.defaultNameFor].
  ///
  /// Phase 9 Batch 9.2:
  ///  - session pages are adopted into the document-owned
  ///    directory (copy, never move)
  ///  - the PDF is written inside the document directory
  ///  - the persisted document stores document-relative page
  ///    references, produced by the shared projection helper on
  ///    [ScannerStorageService]
  ///
  /// Phase 9 Batch 9.8:
  ///  - if any step after adoption fails (PDF generation,
  ///    projection, or index persistence), the newly-created
  ///    document directory is removed before the original
  ///    exception is rethrown. The session directory is never
  ///    touched, so the user can retry the export.
  ///
  /// Phase 10A.1:
  ///  - when [format] is [ScannerExportFormat.searchablePdf],
  ///    Latin-only OCR runs on every adopted page inside the
  ///    existing try block, and the resulting per-page
  ///    [OcrResult] values are passed to the PDF service to
  ///    produce an invisible searchable text layer.
  Future<ScannerDocument> exportDocument({
    required String documentId,
    required ScannerSession session,
    required ScannerExportFormat format,
    ScannerDocumentCategory? category,
    List<String> tags = const [],
    String? nameOverride,
  }) async {
    if (session.pages.isEmpty) {
      throw const ScannerOrchestratorException(
        'Cannot export a document with zero pages.',
      );
    }

    await _storage.ensureReady();

    final now = DateTime.now();
    final resolvedCategory =
        category ?? ScannerDocumentCategory.other;

    final trimmedOverride = nameOverride?.trim();
    final resolvedName =
        (trimmedOverride != null && trimmedOverride.isNotEmpty)
            ? trimmedOverride
            : ScannerNamingUtils.defaultNameFor(
                resolvedCategory,
                now: now,
              );

    final metadata = DocumentMetadata(
      id: documentId,
      name: resolvedName,
      category: resolvedCategory,
      createdAt: now,
      updatedAt: now,
      pageCount: session.pages.length,
      tags: List.unmodifiable(tags),
    );

    final adoptedPages = await _storage.adoptPages(
      documentId: documentId,
      sessionId: session.id,
      sessionPages: session.pages,
    );

    try {
      final isSearchable =
          format == ScannerExportFormat.searchablePdf;
      final isPdfFormat = format == ScannerExportFormat.pdf ||
          format == ScannerExportFormat.both ||
          isSearchable;

      PdfDocument? pdfDoc;
      if (isPdfFormat) {
        final pdfPath =
            await ScannerFileUtils.buildDocumentPdfPath(documentId);

        List<OcrResult>? ocrResults;
        if (isSearchable) {
          ocrResults = await _runSearchableOcr(adoptedPages);
        }

        pdfDoc = await _pdf.buildPdf(
          pages: adoptedPages,
          metadata: metadata,
          outputPath: pdfPath,
          ocrResults: ocrResults,
        );
      }

      final document = ScannerDocument(
        id: documentId,
        metadata: metadata,
        pages: adoptedPages,
        ocrResult: null,
        pdfDocument: pdfDoc,
        exportFormat: format,
      );

      final persisted =
          await _storage.projectDocumentForPersistence(document);

      await _storage.upsertDocument(persisted);
      return document;
    } catch (_) {
      await _cleanupFailedExportDirectory(documentId);
      rethrow;
    }
  }

  // ============================================================
  // Internal helpers
  // ============================================================

  /// Runs Latin-only OCR on every adopted page, in page order,
  /// and returns the results index-aligned with [pages].
  ///
  /// Phase 10A.1 is Latin/English only; this method deliberately
  /// does not read `session.settings.ocrLanguage`. Non-Latin
  /// script support belongs to Phase 10B.
  ///
  /// If any page fails OCR, the exception propagates and the
  /// caller's try/catch (Batch 9.8) removes the failed document
  /// directory before rethrowing.
  Future<List<OcrResult>> _runSearchableOcr(
    List<ScannerPage> pages,
  ) async {
    final results = <OcrResult>[];
    for (final page in pages) {
      final result = await _ocr.extractText(
        imagePath: page.imagePath,
        language: ScannerLanguage.latin,
        pageId: page.id,
      );
      results.add(result);
    }
    return results;
  }

  /// Removes `documents/<documentId>/` after a failed export.
  ///
  /// The index has not been written at this point, so only the
  /// filesystem directory needs to be removed. Failures during
  /// cleanup are swallowed so the caller sees the original export
  /// exception rather than a cleanup exception.
  Future<void> _cleanupFailedExportDirectory(
    String documentId,
  ) async {
    try {
      final dir = await ScannerFileUtils.documentDir(documentId);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    } catch (_) {
      // Ignore cleanup failures so the original export error
      // propagates to the caller.
    }
  }

  Future<String> _copyTo(String src, String dst) async {
    final srcFile = File(src);
    if (!await srcFile.exists()) {
      throw ScannerOrchestratorException(
        'Source file does not exist: $src',
      );
    }
    final dstFile = File(dst);
    await dstFile.parent.create(recursive: true);
    await srcFile.copy(dstFile.path);
    return dstFile.path;
  }

  Future<({int width, int height})> _readImageSize(
    String path,
  ) async {
    final file = File(path);
    if (!await file.exists()) {
      throw ScannerOrchestratorException(
        'Image file does not exist: $path',
      );
    }
    final bytes = await file.readAsBytes();
    final decoded = img.decodeImage(bytes);
    if (decoded == null) {
      throw ScannerOrchestratorException(
        'Failed to decode image: $path',
      );
    }
    return (width: decoded.width, height: decoded.height);
  }
}
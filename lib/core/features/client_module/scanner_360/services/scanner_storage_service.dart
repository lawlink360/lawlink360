import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/scanner_constants.dart';
import '../models/document_metadata.dart';
import '../models/ocr_result.dart';
import '../models/pdf_document.dart';
import '../models/scanner_document.dart';
import '../models/scanner_folder.dart';
import '../models/scanner_page.dart';
import '../utils/scanner_file_utils.dart';

/// Raised when local persistence fails.
class ScannerStorageException implements Exception {
  const ScannerStorageException(this.message);
  final String message;

  @override
  String toString() => 'ScannerStorageException: $message';
}

/// Raised when a scanner source asset required for an operation is
/// missing from disk. Carries a user-facing message with no internal
/// filesystem path.
///
/// Currently only thrown by
/// [ScannerStorageService.duplicateDocument] when a source page
/// image file is absent.
class ScannerSourceAssetMissingException implements Exception {
  const ScannerSourceAssetMissingException(this.message);
  final String message;

  @override
  String toString() =>
      'ScannerSourceAssetMissingException: $message';
}

class ScannerStorageService {
  const ScannerStorageService();

  // ============================================================
  // Setup
  // ============================================================

  Future<void> ensureReady() async {
    await ScannerFileUtils.ensureAllScannerDirectories();
  }

  // ============================================================
  // Document index
  // ============================================================

  Future<List<ScannerDocument>> loadAllDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(ScannerConstants.documentIndexKey);
    if (raw == null || raw.isEmpty) return const [];

    try {
      final decoded = jsonDecode(raw) as List;
      return decoded
          .map((e) =>
              ScannerDocument.fromMap((e as Map).cast<String, dynamic>()))
          .toList(growable: false);
    } catch (e) {
      throw ScannerStorageException(
        'Failed to parse document index: $e',
      );
    }
  }

  Future<void> saveDocumentIndex(
    List<ScannerDocument> documents,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      documents.map((d) => d.toMap()).toList(),
    );
    final ok = await prefs.setString(
      ScannerConstants.documentIndexKey,
      encoded,
    );
    if (!ok) {
      throw const ScannerStorageException(
        'Failed to write document index.',
      );
    }
  }

  Future<void> upsertDocument(ScannerDocument document) async {
    final all = await loadAllDocuments();
    final updated = <ScannerDocument>[
      for (final d in all)
        if (d.id != document.id) d,
      document,
    ];
    await saveDocumentIndex(updated);
  }

  Future<void> removeDocument(String documentId) async {
    final all = await loadAllDocuments();
    final updated = all
        .where((d) => d.id != documentId)
        .toList(growable: false);
    await saveDocumentIndex(updated);
  }

  Future<void> updateDocuments(
    Map<String, ScannerDocument> updates,
  ) async {
    if (updates.isEmpty) return;

    final all = await loadAllDocuments();
    final updated = <ScannerDocument>[];
    for (final doc in all) {
      final replacement = updates[doc.id];
      updated.add(replacement ?? doc);
    }
    await saveDocumentIndex(updated);
  }

  // ============================================================
  // Folder index
  // ============================================================

  Future<List<ScannerFolder>> loadAllFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(ScannerConstants.folderIndexKey);
    if (raw == null || raw.isEmpty) return const [];

    try {
      final decoded = jsonDecode(raw) as List;
      return decoded
          .map((e) =>
              ScannerFolder.fromMap((e as Map).cast<String, dynamic>()))
          .toList(growable: false);
    } catch (e) {
      throw ScannerStorageException(
        'Failed to parse folder index: $e',
      );
    }
  }

  Future<void> saveFolderIndex(
    List<ScannerFolder> folders,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      folders.map((f) => f.toMap()).toList(),
    );
    final ok = await prefs.setString(
      ScannerConstants.folderIndexKey,
      encoded,
    );
    if (!ok) {
      throw const ScannerStorageException(
        'Failed to write folder index.',
      );
    }
  }

  Future<void> upsertFolder(ScannerFolder folder) async {
    final all = await loadAllFolders();
    final updated = <ScannerFolder>[
      for (final f in all)
        if (f.id != folder.id) f,
      folder,
    ];
    await saveFolderIndex(updated);
  }

  Future<void> removeFolder(String folderId) async {
    final all = await loadAllFolders();
    final updated = all
        .where((f) => f.id != folderId)
        .toList(growable: false);
    await saveFolderIndex(updated);
  }

  // ============================================================
  // Page image files (legacy global folders — unchanged)
  // ============================================================

  Future<String> newPageImagePath(String pageId) {
    return ScannerFileUtils.buildPageImagePath(pageId);
  }

  Future<String> newThumbnailPath(String pageId) {
    return ScannerFileUtils.buildThumbnailPath(pageId);
  }

  Future<void> deletePageFiles({
    required String pageId,
    String? imagePath,
    String? thumbnailPath,
  }) {
    return ScannerFileUtils.deletePageFiles(
      pageId,
      imagePath: imagePath,
      thumbnailPath: thumbnailPath,
    );
  }

  // ============================================================
  // PDF files (legacy global folder — unchanged)
  // ============================================================

  Future<String> newPdfPath(String documentId) {
    return ScannerFileUtils.buildPdfPath(documentId);
  }

  Future<void> deletePdf(String path) {
    return ScannerFileUtils.deleteIfExists(path);
  }

  // ============================================================
  // Document-owned asset adoption
  // ============================================================

  Future<List<ScannerPage>> adoptPages({
    required String documentId,
    required String sessionId,
    required List<ScannerPage> sessionPages,
  }) async {
    await ScannerFileUtils.ensureDocumentDirectories(documentId);

    final adopted = <ScannerPage>[];
    try {
      for (final page in sessionPages) {
        final destination = await ScannerFileUtils.buildDocumentPagePath(
          documentId,
          page.id,
        );

        final source = File(page.imagePath);
        if (!await source.exists()) {
          throw ScannerStorageException(
            'Session page image missing: ${page.imagePath}',
          );
        }

        final destFile = File(destination);
        await destFile.parent.create(recursive: true);
        await source.copy(destFile.path);

        adopted.add(page.copyWith(imagePath: destFile.path));
      }
    } catch (e) {
      try {
        final dir = await ScannerFileUtils.documentDir(documentId);
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
      } catch (_) {
        // Ignore cleanup failures so the original error surfaces.
      }
      rethrow;
    }

    return adopted;
  }

  Future<String> resolvePageAsset({
    required String documentId,
    required String reference,
  }) async {
    if (reference.isEmpty) return reference;
    if (File(reference).isAbsolute) return reference;

    final dir = await ScannerFileUtils.documentDir(documentId);
    final separator = Platform.pathSeparator;
    return '${dir.path}$separator$reference';
  }

  Future<ScannerDocument> projectDocumentForPersistence(
    ScannerDocument document,
  ) async {
    if (document.pages.isEmpty) return document;

    final docDir = await ScannerFileUtils.documentDir(document.id);
    final prefix = '${docDir.path}${Platform.pathSeparator}';

    final projectedPages = <ScannerPage>[];
    for (final page in document.pages) {
      final path = page.imagePath;
      if (path.startsWith(prefix)) {
        projectedPages.add(
          page.copyWith(imagePath: path.substring(prefix.length)),
        );
      } else {
        projectedPages.add(page);
      }
    }

    return document.copyWith(pages: projectedPages);
  }

  Future<void> deleteSessionAssets({
    required String sessionId,
  }) async {
    final dir = await ScannerFileUtils.sessionDir(sessionId);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  // ============================================================
  // Full document deletion
  // ============================================================

  /// Removes the index entry and the entire document-owned
  /// directory tree:
  ///   `scanner_360/documents/<documentId>/`
  ///
  /// Legacy documents that still reference global paths outside
  /// the document directory will not have those global files
  /// removed by this method. Those are left for a later,
  /// explicitly-scoped cleanup batch.
  Future<void> deleteDocumentCompletely(
    ScannerDocument document,
  ) async {
    final dir = await ScannerFileUtils.documentDir(document.id);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
    await removeDocument(document.id);
  }

  /// Batch variant of [deleteDocumentCompletely].
  ///
  /// For the given [documentIds]:
  ///  - loads the document index exactly once
  ///  - deletes the document-owned directory of every document
  ///    whose id is present in the set and whose directory exists
  ///  - removes every targeted id from the index
  ///  - saves the index exactly once
  ///
  /// Empty sets are a no-op. Unknown ids are ignored; ids that do
  /// not resolve to an index entry produce no directory delete
  /// attempt and no index change.
  ///
  /// Error semantics match the single-document path: a failure
  /// while deleting a document directory propagates before the
  /// index is saved, so the index continues to reference the
  /// documents whose directories could not be removed. Missing
  /// directories are silently skipped, as in the single-document
  /// path (`if (await dir.exists())`).
  Future<void> deleteDocumentsCompletely(
    Set<String> documentIds,
  ) async {
    if (documentIds.isEmpty) return;

    final all = await loadAllDocuments();

    // Delete each targeted document's owned directory. The set of
    // ids actually present in the index is what we will remove on
    // save; ids that resolve to no index entry are ignored.
    final present = <String>{};
    for (final doc in all) {
      if (!documentIds.contains(doc.id)) continue;
      present.add(doc.id);

      final dir = await ScannerFileUtils.documentDir(doc.id);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    }

    if (present.isEmpty) return;

    final updated = all
        .where((d) => !present.contains(d.id))
        .toList(growable: false);
    await saveDocumentIndex(updated);
  }

  // ============================================================
  // Metadata convenience
  // ============================================================

  Future<void> updateMetadata(DocumentMetadata metadata) async {
    final all = await loadAllDocuments();
    final idx = all.indexWhere((d) => d.id == metadata.id);
    if (idx == -1) {
      throw ScannerStorageException(
        'Cannot update metadata for unknown document: ${metadata.id}',
      );
    }
    final updated = all[idx].copyWith(metadata: metadata);
    final list = List<ScannerDocument>.from(all);
    list[idx] = updated;
    await saveDocumentIndex(list);
  }

  // ============================================================
  // Duplicate (Y6)
  // ============================================================

  Future<ScannerDocument> duplicateDocument({
    required ScannerDocument source,
    required String newDocumentId,
  }) async {
    final now = DateTime.now();

    await ScannerFileUtils.ensureDocumentDirectories(newDocumentId);

    try {
      final newPages = <ScannerPage>[];
      for (final sourcePage in source.pages) {
        final newPageId = _newPageId(now, newPages.length);

        final resolvedSourceImage = await resolvePageAsset(
          documentId: source.id,
          reference: sourcePage.imagePath,
        );

        final sourceImageFile = File(resolvedSourceImage);
        if (!await sourceImageFile.exists()) {
          throw const ScannerSourceAssetMissingException(
            'This document contains a missing page and '
            'cannot be duplicated.',
          );
        }

        final newImagePath = await ScannerFileUtils.buildDocumentPagePath(
          newDocumentId,
          newPageId,
        );
        final newImageFile = File(newImagePath);
        await newImageFile.parent.create(recursive: true);
        await sourceImageFile.copy(newImageFile.path);

        String? newThumbnailPath;
        final sourceThumbnail = sourcePage.thumbnailPath;
        if (sourceThumbnail != null && sourceThumbnail.isNotEmpty) {
          final resolvedSourceThumb = await resolvePageAsset(
            documentId: source.id,
            reference: sourceThumbnail,
          );
          final sourceThumbFile = File(resolvedSourceThumb);
          if (await sourceThumbFile.exists()) {
            final newThumbCandidate =
                await ScannerFileUtils.buildDocumentThumbnailPath(
              newDocumentId,
              newPageId,
            );
            final newThumbFile = File(newThumbCandidate);
            await newThumbFile.parent.create(recursive: true);
            await sourceThumbFile.copy(newThumbFile.path);
            newThumbnailPath = newThumbFile.path;
          }
        }

        final OcrResult? newOcr = sourcePage.ocrResult?.copyWith(
          pageId: newPageId,
        );

        newPages.add(
          ScannerPage(
            id: newPageId,
            imagePath: newImageFile.path,
            thumbnailPath: newThumbnailPath,
            cropData: sourcePage.cropData,
            filter: sourcePage.filter,
            rotation: sourcePage.rotation,
            width: sourcePage.width,
            height: sourcePage.height,
            ocrResult: newOcr,
            createdAt: now,
          ),
        );
      }

      PdfDocument? newPdfDoc;
      final sourcePdf = source.pdfDocument;
      if (sourcePdf != null) {
        final sourcePdfFile = File(sourcePdf.filePath);
        if (!await sourcePdfFile.exists()) {
          throw const ScannerSourceAssetMissingException(
            'This document contains a missing file and '
            'cannot be duplicated.',
          );
        }

        final newPdfPath = await ScannerFileUtils.buildDocumentPdfPath(
          newDocumentId,
        );
        final newPdfFile = File(newPdfPath);
        await newPdfFile.parent.create(recursive: true);
        await sourcePdfFile.copy(newPdfFile.path);

        newPdfDoc = PdfDocument(
          id: newDocumentId,
          filePath: newPdfFile.path,
          pageCount: sourcePdf.pageCount,
          sizeInBytes: sourcePdf.sizeInBytes,
          createdAt: now,
          isSearchable: sourcePdf.isSearchable,
        );
      }

      final sourceMeta = source.metadata;
      final newMetadata = DocumentMetadata(
        id: newDocumentId,
        name: '${sourceMeta.name} (Copy)',
        category: sourceMeta.category,
        createdAt: now,
        updatedAt: now,
        pageCount: newPages.length,
        isFavorite: false,
        tags: List<String>.from(sourceMeta.tags),
        linkedCaseId: sourceMeta.linkedCaseId,
        linkedClientId: sourceMeta.linkedClientId,
        linkedLawyerId: sourceMeta.linkedLawyerId,
        linkedMatterId: sourceMeta.linkedMatterId,
        folderId: sourceMeta.folderId,
      );

      final duplicate = ScannerDocument(
        id: newDocumentId,
        metadata: newMetadata,
        pages: newPages,
        ocrResult: source.ocrResult,
        pdfDocument: newPdfDoc,
        exportFormat: source.exportFormat,
      );

      final projected = await projectDocumentForPersistence(duplicate);
      await upsertDocument(projected);

      return duplicate;
    } catch (e) {
      try {
        final dir = await ScannerFileUtils.documentDir(newDocumentId);
        if (await dir.exists()) {
          await dir.delete(recursive: true);
        }
      } catch (_) {
        // Ignore cleanup failures so the original error surfaces.
      }
      rethrow;
    }
  }

  String _newPageId(DateTime now, int index) =>
      '${now.microsecondsSinceEpoch}_$index';
}
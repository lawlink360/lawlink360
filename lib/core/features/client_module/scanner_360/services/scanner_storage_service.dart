import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/scanner_constants.dart';
import '../models/document_metadata.dart';
import '../models/scanner_document.dart';
import '../models/scanner_page.dart';
import '../utils/scanner_file_utils.dart';

/// Raised when local persistence fails.
class ScannerStorageException implements Exception {
  const ScannerStorageException(this.message);
  final String message;

  @override
  String toString() => 'ScannerStorageException: $message';
}

/// Owns the local filesystem layout and the shared_preferences
/// document index for Scanner 360.
///
/// Responsibilities:
///  - creating the scanner root directory tree
///  - writing and reading page image files
///  - writing and reading PDF files
///  - maintaining a serialized ScannerDocument index in
///    shared_preferences
///  - adopting session-owned page assets into a document-owned
///    directory at export time
///  - resolving document-relative references into absolute
///    filesystem paths on load
///  - projecting absolute in-memory paths back to document-relative
///    references on save
///
/// This service is the single boundary that owns the persisted
/// path shape. Callers above it work in absolute paths; the index
/// stores document-relative references.
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

  /// Copies [sessionPages] image files into the document-owned
  /// pages directory and returns new [ScannerPage] instances whose
  /// [ScannerPage.imagePath] is the absolute path of the copied
  /// file.
  ///
  /// Session files are never moved or deleted here. If any copy
  /// fails, the partially-created document directory is removed
  /// before the original failure is rethrown.
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

  /// Resolves a persisted [reference] into an absolute filesystem
  /// path.
  ///
  /// Absolute references are returned unchanged (legacy
  /// compatibility). Relative references are resolved under the
  /// document-owned directory.
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

  /// Projects in-memory absolute page paths back into their
  /// persisted document-relative form.
  ///
  /// Only paths that begin with the document's own directory
  /// prefix are rewritten. Legacy absolute paths outside the
  /// document directory are preserved unchanged.
  ///
  /// Returns a new [ScannerDocument]; the input is not mutated.
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

  /// Recursively deletes the session-owned directory tree:
  ///   `scanner_360/sessions/<sessionId>/`
  ///
  /// Never touches the `documents/` directory.
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
}
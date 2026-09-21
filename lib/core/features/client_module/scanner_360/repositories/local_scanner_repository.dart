import '../models/scanner_document.dart';
import '../models/scanner_page.dart';
import '../services/scanner_storage_service.dart';
import 'scanner_repository.dart';

/// Raised when a repository operation fails.
class LocalScannerRepositoryException implements Exception {
  const LocalScannerRepositoryException(this.message);
  final String message;

  @override
  String toString() => 'LocalScannerRepositoryException: $message';
}

/// Local, file-and-shared-preferences-backed implementation of
/// [ScannerRepository].
///
/// Delegates all persistence work to [ScannerStorageService]. This
/// class implements search, filtering, and ordering in memory over
/// the loaded index.
///
/// Phase 9 Batch 9.2 — this repository is the boundary between
/// document-relative persisted page references and absolute
/// in-memory filesystem paths:
///  - on load, relative references are resolved into absolute
///    paths through [ScannerStorageService.resolvePageAsset]
///  - on save, the projection to relative form is delegated to
///    [ScannerStorageService.projectDocumentForPersistence] so
///    there is exactly one implementation of that conversion
///    across the module
class LocalScannerRepository implements ScannerRepository {
  LocalScannerRepository({
    ScannerStorageService? storage,
  }) : _storage = storage ?? const ScannerStorageService();

  final ScannerStorageService _storage;

  // ============================================================
  // Read
  // ============================================================

  @override
  Future<ScannerDocument?> getDocument(String id) async {
    final all = await _storage.loadAllDocuments();
    for (final doc in all) {
      if (doc.id == id) {
        return await _resolveDocument(doc);
      }
    }
    return null;
  }

  @override
  Future<List<ScannerDocument>> getAllDocuments() async {
    final all = await _storage.loadAllDocuments();
    final list = List<ScannerDocument>.from(all);
    list.sort(
      (a, b) => b.metadata.updatedAt.compareTo(a.metadata.updatedAt),
    );
    return await _resolveAll(list);
  }

  @override
  Future<List<ScannerDocument>> getRecentDocuments({
    int limit = 20,
  }) async {
    final all = await getAllDocuments();
    if (all.length <= limit) return all;
    return all.sublist(0, limit);
  }

  @override
  Future<List<ScannerDocument>> getFavoriteDocuments() async {
    final all = await getAllDocuments();
    return all
        .where((d) => d.metadata.isFavorite)
        .toList(growable: false);
  }

  @override
  Future<List<ScannerDocument>> searchDocuments(String query) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return getAllDocuments();

    final all = await getAllDocuments();
    return all.where((d) {
      if (d.metadata.name.toLowerCase().contains(trimmed)) {
        return true;
      }
      for (final tag in d.metadata.tags) {
        if (tag.toLowerCase().contains(trimmed)) {
          return true;
        }
      }
      return false;
    }).toList(growable: false);
  }

  // ============================================================
  // Write
  // ============================================================

  @override
  Future<void> saveDocument(ScannerDocument document) async {
    final projected =
        await _storage.projectDocumentForPersistence(document);
    await _storage.upsertDocument(projected);
  }

  @override
  Future<void> deleteDocument(String id) async {
    final existing = await getDocument(id);
    if (existing == null) {
      throw LocalScannerRepositoryException(
        'Cannot delete unknown document: $id',
      );
    }
    await _storage.deleteDocumentCompletely(existing);
  }

  @override
  Future<void> renameDocument(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw const LocalScannerRepositoryException(
        'Document name cannot be empty.',
      );
    }

    final existing = await getDocument(id);
    if (existing == null) {
      throw LocalScannerRepositoryException(
        'Cannot rename unknown document: $id',
      );
    }

    final updatedMetadata = existing.metadata.copyWith(
      name: trimmed,
      updatedAt: DateTime.now(),
    );

    final updatedDocument = existing.copyWith(
      metadata: updatedMetadata,
    );

    final projected =
        await _storage.projectDocumentForPersistence(updatedDocument);
    await _storage.upsertDocument(projected);
  }

  @override
  Future<void> setFavorite(String id, bool value) async {
    final existing = await getDocument(id);
    if (existing == null) {
      throw LocalScannerRepositoryException(
        'Cannot update favourite for unknown document: $id',
      );
    }

    final updatedMetadata = existing.metadata.copyWith(
      isFavorite: value,
      updatedAt: DateTime.now(),
    );

    final updatedDocument = existing.copyWith(
      metadata: updatedMetadata,
    );

    final projected =
        await _storage.projectDocumentForPersistence(updatedDocument);
    await _storage.upsertDocument(projected);
  }

  // ============================================================
  // Resolution boundary
  // ============================================================

  @override
  Future<String> resolvePageAsset(
    String documentId,
    String reference,
  ) {
    return _storage.resolvePageAsset(
      documentId: documentId,
      reference: reference,
    );
  }

  // ============================================================
  // Internal helpers
  // ============================================================

  /// Resolves every page in [document] from its persisted
  /// document-relative reference into an absolute in-memory path.
  /// Legacy absolute references are left unchanged.
  Future<ScannerDocument> _resolveDocument(
    ScannerDocument document,
  ) async {
    if (document.pages.isEmpty) return document;

    final resolvedPages = <ScannerPage>[];
    for (final page in document.pages) {
      final resolved = await _storage.resolvePageAsset(
        documentId: document.id,
        reference: page.imagePath,
      );
      resolvedPages.add(page.copyWith(imagePath: resolved));
    }

    return document.copyWith(pages: resolvedPages);
  }

  Future<List<ScannerDocument>> _resolveAll(
    List<ScannerDocument> documents,
  ) async {
    final out = <ScannerDocument>[];
    for (final doc in documents) {
      out.add(await _resolveDocument(doc));
    }
    return out;
  }
}
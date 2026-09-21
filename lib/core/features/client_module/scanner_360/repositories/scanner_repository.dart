import '../models/scanner_document.dart';

/// Persistence contract for Scanner 360 documents.
///
/// This is the single abstraction point in the scanner module where
/// a future backend swap genuinely matters. Phase 4 ships only the
/// local implementation. A Firebase implementation can be added
/// later without changing any caller.
///
/// No Riverpod provider is created in Phase 4. The concrete
/// implementation is wired in Phase 6.
abstract class ScannerRepository {
  /// Persists [document], replacing any existing entry with the
  /// same id.
  Future<void> saveDocument(ScannerDocument document);

  /// Returns the document with [id], or null if not found.
  Future<ScannerDocument?> getDocument(String id);

  /// Returns every stored document.
  Future<List<ScannerDocument>> getAllDocuments();

  /// Returns the most recently updated documents, newest first.
  Future<List<ScannerDocument>> getRecentDocuments({int limit = 20});

  /// Returns only documents flagged as favourite.
  Future<List<ScannerDocument>> getFavoriteDocuments();

  /// Case-insensitive substring search over document name and tags.
  Future<List<ScannerDocument>> searchDocuments(String query);

  /// Deletes the document with [id] and all of its files.
  Future<void> deleteDocument(String id);

  /// Renames the document with [id] to [name].
  Future<void> renameDocument(String id, String name);

  /// Updates the favourite flag for the document with [id].
  Future<void> setFavorite(String id, bool value);

  /// Resolves a persisted document page reference into an absolute
  /// filesystem path.
  ///
  /// Absolute references are returned unchanged (legacy
  /// compatibility). Relative references are resolved against the
  /// document's owned directory.
  Future<String> resolvePageAsset(String documentId, String reference);
}
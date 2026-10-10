import '../models/scanner_document.dart';
import '../models/scanner_folder.dart';

/// Persistence contract for Scanner 360 documents and folders.
///
/// This is the single abstraction point in the scanner module where
/// a future backend swap genuinely matters. Phase 4 ships only the
/// local implementation. A Firebase implementation can be added
/// later without changing any caller.
///
/// No Riverpod provider is created in Phase 4. The concrete
/// implementation is wired in Phase 6.
abstract class ScannerRepository {
  // ============================================================
  // Documents
  // ============================================================

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

  /// Deletes every document whose id is present in [documentIds]
  /// and all of their files.
  ///
  /// Empty sets are a no-op. Unknown ids are ignored.
  ///
  /// This is a true batch operation: the underlying storage performs
  /// exactly one index load and one index save for the whole set.
  Future<void> deleteDocuments(Set<String> documentIds);

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

  /// Applies [updates] as a single persisted write.
  ///
  /// Each map entry is keyed by document id and supplies a
  /// [ScannerDocument] that replaces the current entry with the same
  /// id. Ids not present in [updates] are preserved unchanged.
  ///
  /// Unknown ids in [updates] are ignored; a batch that references
  /// a document that does not exist does not create it.
  ///
  /// This is the batch persistence primitive required by future
  /// bulk operations (move, favourite, delete). It performs exactly
  /// one index load and one index save.
  Future<void> updateDocuments(
    Map<String, ScannerDocument> updates,
  );

  /// Creates a fully independent duplicate of the document with
  /// [sourceDocumentId] and returns the persisted duplicate.
  Future<ScannerDocument> duplicateDocument(String sourceDocumentId);

  // ============================================================
  // Folders
  // ============================================================

  /// Persists [folder], replacing any existing entry with the same
  /// id.
  Future<void> saveFolder(ScannerFolder folder);

  /// Returns the folder with [id], or null if not found.
  Future<ScannerFolder?> getFolder(String id);

  /// Returns every stored folder.
  Future<List<ScannerFolder>> getAllFolders();

  /// Renames the folder with [id] to [name] and updates its
  /// `updatedAt` timestamp.
  Future<void> renameFolder(String id, String name);

  /// Deletes the folder with [id].
  ///
  /// This removes the folder record only. It does not reassign
  /// documents and does not touch child folders. Reassignment and
  /// child-folder refusal are higher-level operations performed by
  /// callers once those batches are authorized.
  Future<void> deleteFolder(String id);
}
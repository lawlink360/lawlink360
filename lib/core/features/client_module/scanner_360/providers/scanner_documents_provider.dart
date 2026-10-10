import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/scanner_document.dart';
import '../models/scanner_folder.dart';
import '../repositories/local_scanner_repository.dart';

/// Raised when a folder mutation cannot be completed for a
/// product-rule reason (for example, refusing deletion of a folder
/// that contains child folders, or moving a document to an unknown
/// target folder).
class ScannerFolderRuleException implements Exception {
  const ScannerFolderRuleException(this.message);
  final String message;

  @override
  String toString() => 'ScannerFolderRuleException: $message';
}

/// Async repository-backed list of saved scanner documents.
///
/// The notifier owns the read-only folder-navigation state, the
/// Y4 folder mutation operations, the Y5 document move operation,
/// the Y6 duplicate operation, and the Y7 selection state plus
/// bulk Move / bulk Favourite orchestration.
///
/// Search is global. Starting a non-empty search clears the current
/// folder context; clearing the search returns to root.
///
/// The provider never touches dart:io, File, SharedPreferences, or
/// filesystem paths. All persistence goes through
/// [LocalScannerRepository].
class ScannerDocumentsNotifier
    extends AsyncNotifier<List<ScannerDocument>> {
  final LocalScannerRepository _repository = LocalScannerRepository();

  String? _currentFolderId;
  List<ScannerFolder> _foldersInCurrentContext = const [];
  List<ScannerFolder> _allFolders = const [];

  // ---- Y7.1 selection state ----------------------------------
  bool _isSelectionMode = false;
  Set<String> _selectedDocumentIds = <String>{};

  String? get currentFolderId => _currentFolderId;

  ScannerFolder? get currentFolder {
    final id = _currentFolderId;
    if (id == null) return null;
    for (final f in _allFolders) {
      if (f.id == id) return f;
    }
    return null;
  }

  List<ScannerFolder> get foldersInCurrentContext =>
      List.unmodifiable(_foldersInCurrentContext);

  List<ScannerFolder> get allFolders =>
      List.unmodifiable(_allFolders);

  bool get isSelectionMode => _isSelectionMode;

  Set<String> get selectedDocumentIds =>
      Set.unmodifiable(_selectedDocumentIds);

  int get selectedCount => _selectedDocumentIds.length;

  bool allVisibleSelected(List<ScannerDocument> visible) {
    if (visible.isEmpty) return false;
    if (_selectedDocumentIds.length != visible.length) return false;
    for (final doc in visible) {
      if (!_selectedDocumentIds.contains(doc.id)) return false;
    }
    return true;
  }

  @override
  Future<List<ScannerDocument>> build() async {
    _allFolders = await _repository.getAllFolders();
    _foldersInCurrentContext = _foldersForParent(_currentFolderId);
    return _documentsForFolder(_currentFolderId);
  }

  // ============================================================
  // Y7.1 selection methods
  // ============================================================

  void enterSelectionMode(String documentId) {
    if (!_isVisible(documentId)) return;
    _isSelectionMode = true;
    _selectedDocumentIds = <String>{documentId};
    state = AsyncData(
      state.valueOrNull ?? const <ScannerDocument>[],
    );
  }

  void clearSelection() {
    if (!_isSelectionMode && _selectedDocumentIds.isEmpty) return;
    _isSelectionMode = false;
    _selectedDocumentIds = <String>{};
    state = AsyncData(
      state.valueOrNull ?? const <ScannerDocument>[],
    );
  }

  void toggleSelection(String documentId) {
    if (!_isVisible(documentId)) return;

    final next = Set<String>.from(_selectedDocumentIds);
    if (next.contains(documentId)) {
      next.remove(documentId);
    } else {
      next.add(documentId);
    }

    _selectedDocumentIds = next;
    if (_selectedDocumentIds.isEmpty) {
      _isSelectionMode = false;
    } else {
      _isSelectionMode = true;
    }

    state = AsyncData(
      state.valueOrNull ?? const <ScannerDocument>[],
    );
  }

  void selectAllVisible(List<ScannerDocument> visible) {
    if (visible.isEmpty) {
      _selectedDocumentIds = <String>{};
      _isSelectionMode = false;
    } else {
      _selectedDocumentIds = visible.map((d) => d.id).toSet();
      _isSelectionMode = true;
    }

    state = AsyncData(
      state.valueOrNull ?? const <ScannerDocument>[],
    );
  }

  bool _isVisible(String documentId) {
    final docs = state.valueOrNull;
    if (docs == null) return false;
    for (final d in docs) {
      if (d.id == documentId) return true;
    }
    return false;
  }

  // ============================================================
  // Folder navigation
  // ============================================================

  Future<void> goToRoot() async {
    clearSelection();
    state = const AsyncLoading();
    try {
      _allFolders = await _repository.getAllFolders();
      _currentFolderId = null;
      _foldersInCurrentContext = _foldersForParent(null);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, null));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> goToFolder(String folderId) async {
    clearSelection();
    state = const AsyncLoading();
    try {
      _allFolders = await _repository.getAllFolders();
      final exists = _allFolders.any((f) => f.id == folderId);
      if (!exists) {
        _currentFolderId = null;
        _foldersInCurrentContext = _foldersForParent(null);
        final docs = await _repository.getAllDocuments();
        state = AsyncData(_filterByFolder(docs, null));
        return;
      }
      _currentFolderId = folderId;
      _foldersInCurrentContext = _foldersForParent(folderId);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, folderId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> goToParent() async {
    final id = _currentFolderId;
    if (id == null) return;
    final current = currentFolder;
    final parentId = current?.parentFolderId;
    if (parentId == null) {
      await goToRoot();
    } else {
      await goToFolder(parentId);
    }
  }

  // ============================================================
  // Folder mutations (Y4)
  // ============================================================

  Future<ScannerFolder> createFolder(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw const ScannerFolderRuleException(
        'Folder name cannot be empty.',
      );
    }

    final now = DateTime.now();
    final folder = ScannerFolder(
      id: _newFolderId(now),
      name: trimmed,
      parentFolderId: _currentFolderId,
      createdAt: now,
      updatedAt: now,
    );

    await _repository.saveFolder(folder);
    await _reloadCurrentContext();
    return folder;
  }

  Future<void> renameFolder(String id, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw const ScannerFolderRuleException(
        'Folder name cannot be empty.',
      );
    }
    await _repository.renameFolder(id, trimmed);
    await _reloadCurrentContext();
  }

  Future<void> deleteFolder(String id) async {
    final folder = await _repository.getFolder(id);
    if (folder == null) {
      await _reloadCurrentContext();
      return;
    }

    final allFolders = await _repository.getAllFolders();
    final hasChildFolders =
        allFolders.any((f) => f.parentFolderId == id);
    if (hasChildFolders) {
      throw const ScannerFolderRuleException(
        'This folder contains subfolders. Delete or move them first.',
      );
    }

    final newParentId = folder.parentFolderId;
    final allDocs = await _repository.getAllDocuments();
    final affected = allDocs
        .where((d) => d.metadata.folderId == id)
        .toList(growable: false);

    if (affected.isNotEmpty) {
      final now = DateTime.now();
      final updates = <String, ScannerDocument>{};
      for (final doc in affected) {
        final updatedMetadata = doc.metadata.copyWith(
          folderId: newParentId,
          clearFolderId: newParentId == null,
          updatedAt: now,
        );
        updates[doc.id] = doc.copyWith(metadata: updatedMetadata);
      }
      await _repository.updateDocuments(updates);
    }

    await _repository.deleteFolder(id);

    if (_currentFolderId == id) {
      if (newParentId == null) {
        await goToRoot();
        return;
      }
      await goToFolder(newParentId);
      return;
    }

    await _reloadCurrentContext();
  }

  // ============================================================
  // Document move (Y5 — single)
  // ============================================================

  Future<void> moveDocument(
    String documentId,
    String? targetFolderId,
  ) async {
    final docs = await _repository.getAllDocuments();
    final existing = docs.firstWhere(
      (d) => d.id == documentId,
      orElse: () => throw const ScannerFolderRuleException(
        'Document not found.',
      ),
    );

    if (existing.metadata.folderId == targetFolderId) {
      return;
    }

    if (targetFolderId != null) {
      final allFolders = await _repository.getAllFolders();
      final exists = allFolders.any((f) => f.id == targetFolderId);
      if (!exists) {
        throw const ScannerFolderRuleException(
          'Target folder no longer exists.',
        );
      }
    }

    state = const AsyncLoading();
    try {
      final now = DateTime.now();
      final updatedMetadata = existing.metadata.copyWith(
        folderId: targetFolderId,
        clearFolderId: targetFolderId == null,
        updatedAt: now,
      );
      final updatedDocument = existing.copyWith(
        metadata: updatedMetadata,
      );

      await _repository.updateDocuments({
        updatedDocument.id: updatedDocument,
      });

      await _reloadCurrentContext();
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // ============================================================
  // Document duplicate (Y6)
  // ============================================================

  Future<void> duplicateDocument(String sourceDocumentId) async {
    state = const AsyncLoading();
    try {
      await _repository.duplicateDocument(sourceDocumentId);
      await _reloadCurrentContext();
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  // ============================================================
  // Y7.1 bulk Move and bulk Favourite
  // ============================================================

  /// Moves every document whose id appears in [ids] to
  /// [targetFolderId].
  ///
  /// A null [targetFolderId] means root. A non-null target must
  /// resolve to an existing folder. Empty selection is a no-op.
  /// Documents already in the target folder are skipped.
  ///
  /// Uses the repository batch boundary
  /// (`updateDocuments`) in a single call.
  ///
  /// On success the current library context is reloaded and the
  /// selection is cleared. On failure the error is surfaced
  /// through the existing AsyncValue convention and the selection
  /// is left intact so the user can retry.
  Future<void> bulkMoveDocuments(
    Set<String> ids,
    String? targetFolderId,
  ) async {
    if (ids.isEmpty) return;

    if (targetFolderId != null) {
      final allFolders = await _repository.getAllFolders();
      final exists = allFolders.any((f) => f.id == targetFolderId);
      if (!exists) {
        throw const ScannerFolderRuleException(
          'Target folder no longer exists.',
        );
      }
    }

    final visible = state.valueOrNull ?? const <ScannerDocument>[];
    final now = DateTime.now();
    final updates = <String, ScannerDocument>{};

    for (final doc in visible) {
      if (!ids.contains(doc.id)) continue;
      if (doc.metadata.folderId == targetFolderId) continue;

      final updatedMetadata = doc.metadata.copyWith(
        folderId: targetFolderId,
        clearFolderId: targetFolderId == null,
        updatedAt: now,
      );
      updates[doc.id] = doc.copyWith(metadata: updatedMetadata);
    }

    if (updates.isEmpty) {
      // Nothing to change; still drop selection and refresh so the
      // UI reflects the completed intent.
      clearSelection();
      await _reloadCurrentContext();
      return;
    }

    state = const AsyncLoading();
    try {
      await _repository.updateDocuments(updates);
      clearSelection();
      await _reloadCurrentContext();
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// Sets the favourite flag for every document whose id appears
  /// in [ids] to [value].
  ///
  /// Empty selection is a no-op. Uses one repository batch call.
  /// On success the current library context is reloaded and the
  /// selection is cleared. On failure the error is surfaced
  /// through the existing AsyncValue convention and selection is
  /// preserved.
  Future<void> bulkSetFavorite(Set<String> ids, bool value) async {
    if (ids.isEmpty) return;

    final visible = state.valueOrNull ?? const <ScannerDocument>[];
    final now = DateTime.now();
    final updates = <String, ScannerDocument>{};

    for (final doc in visible) {
      if (!ids.contains(doc.id)) continue;
      if (doc.metadata.isFavorite == value) continue;

      final updatedMetadata = doc.metadata.copyWith(
        isFavorite: value,
        updatedAt: now,
      );
      updates[doc.id] = doc.copyWith(metadata: updatedMetadata);
    }

    if (updates.isEmpty) {
      clearSelection();
      await _reloadCurrentContext();
      return;
    }

    state = const AsyncLoading();
    try {
      await _repository.updateDocuments(updates);
      clearSelection();
      await _reloadCurrentContext();
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  // ============================================================
  // Y7.1 bulk Delete — DEFERRED to Y7.2/Y7.3
  // ============================================================

  /// Bulk delete is not implemented in Y7.1.
  ///
  /// The current repository/storage layer exposes single-document
  /// deletion only (`deleteDocument`). The locked Y7 design
  /// requires batch persistence for bulk delete, not N repeated
  /// single calls. Implementing bulk delete therefore requires
  /// the Y7.2/Y7.3 repository/storage batch-delete method, which
  /// has not been authorized yet.
  ///
  /// Calling this method throws [UnsupportedError] with the
  /// message below so that no caller accidentally falls back to a
  /// non-batch path. It will be replaced when Y7.2/Y7.3 are
  /// authorized.
  Future<void> bulkDeleteDocuments(Set<String> ids) async {
    throw UnsupportedError(
      'bulkDeleteDocuments requires Y7.2/Y7.3 repository/storage '
      'implementation and is intentionally deferred.',
    );
  }

  // ============================================================
  // Document list refresh (existing)
  // ============================================================

  Future<void> refresh() async {
    clearSelection();
    state = const AsyncLoading();
    try {
      _allFolders = await _repository.getAllFolders();
      _foldersInCurrentContext = _foldersForParent(_currentFolderId);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, _currentFolderId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadRecent({int limit = 20}) async {
    clearSelection();
    state = const AsyncLoading();
    try {
      final docs = await _repository.getRecentDocuments(limit: limit);
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadFavorites() async {
    clearSelection();
    state = const AsyncLoading();
    try {
      final docs = await _repository.getFavoriteDocuments();
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> search(String query) async {
    clearSelection();
    state = const AsyncLoading();
    try {
      final trimmed = query.trim();
      if (trimmed.isEmpty) {
        _allFolders = await _repository.getAllFolders();
        _currentFolderId = null;
        _foldersInCurrentContext = _foldersForParent(null);
        final docs = await _repository.getAllDocuments();
        state = AsyncData(_filterByFolder(docs, null));
        return;
      }

      _allFolders = await _repository.getAllFolders();
      _currentFolderId = null;
      _foldersInCurrentContext = _foldersForParent(null);

      final docs = await _repository.searchDocuments(query);
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // ============================================================
  // Document mutations (existing)
  // ============================================================

  Future<void> deleteDocument(String id) async {
    state = const AsyncLoading();
    try {
      await _repository.deleteDocument(id);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, _currentFolderId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> renameDocument(String id, String name) async {
    state = const AsyncLoading();
    try {
      await _repository.renameDocument(id, name);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, _currentFolderId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> setFavorite(String id, bool value) async {
    state = const AsyncLoading();
    try {
      await _repository.setFavorite(id, value);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, _currentFolderId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // ============================================================
  // Internal helpers
  // ============================================================

  Future<void> _reloadCurrentContext() async {
    state = const AsyncLoading();
    try {
      _allFolders = await _repository.getAllFolders();
      _foldersInCurrentContext = _foldersForParent(_currentFolderId);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(_filterByFolder(docs, _currentFolderId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  List<ScannerFolder> _foldersForParent(String? parentId) {
    return _allFolders
        .where((f) => f.parentFolderId == parentId)
        .toList(growable: false);
  }

  List<ScannerDocument> _filterByFolder(
    List<ScannerDocument> docs,
    String? folderId,
  ) {
    return docs
        .where((d) => d.metadata.folderId == folderId)
        .toList(growable: false);
  }

  Future<List<ScannerDocument>> _documentsForFolder(
    String? folderId,
  ) async {
    final docs = await _repository.getAllDocuments();
    return _filterByFolder(docs, folderId);
  }

  String _newFolderId(DateTime now) =>
      'folder_${now.microsecondsSinceEpoch}';
}

final scannerDocumentsProvider =
    AsyncNotifierProvider<ScannerDocumentsNotifier, List<ScannerDocument>>(
  ScannerDocumentsNotifier.new,
);
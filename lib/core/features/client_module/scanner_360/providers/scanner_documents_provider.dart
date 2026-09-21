import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/scanner_document.dart';
import '../repositories/local_scanner_repository.dart';

/// Async repository-backed list of saved scanner documents.
class ScannerDocumentsNotifier
    extends AsyncNotifier<List<ScannerDocument>> {
  final LocalScannerRepository _repository = LocalScannerRepository();

  @override
  Future<List<ScannerDocument>> build() async {
    return _repository.getAllDocuments();
  }

  /// Reloads the full document list.
  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final docs = await _repository.getAllDocuments();
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Loads the most recent documents.
  Future<void> loadRecent({int limit = 20}) async {
    state = const AsyncLoading();
    try {
      final docs = await _repository.getRecentDocuments(limit: limit);
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Loads only favourite documents.
  Future<void> loadFavorites() async {
    state = const AsyncLoading();
    try {
      final docs = await _repository.getFavoriteDocuments();
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Searches documents by name and tags.
  Future<void> search(String query) async {
    state = const AsyncLoading();
    try {
      final docs = await _repository.searchDocuments(query);
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Deletes the document with [id] and refreshes the list.
  Future<void> deleteDocument(String id) async {
    state = const AsyncLoading();
    try {
      await _repository.deleteDocument(id);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Renames the document with [id] and refreshes the list.
  Future<void> renameDocument(String id, String name) async {
    state = const AsyncLoading();
    try {
      await _repository.renameDocument(id, name);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Updates the favourite flag and refreshes the list.
  Future<void> setFavorite(String id, bool value) async {
    state = const AsyncLoading();
    try {
      await _repository.setFavorite(id, value);
      final docs = await _repository.getAllDocuments();
      state = AsyncData(docs);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final scannerDocumentsProvider =
    AsyncNotifierProvider<ScannerDocumentsNotifier, List<ScannerDocument>>(
  ScannerDocumentsNotifier.new,
);
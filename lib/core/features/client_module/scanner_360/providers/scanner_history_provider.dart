import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/local_scanner_repository.dart';

/// Async recently-viewed document history.
///
/// Phase 5 keeps history in memory only. Persistence is deferred
/// to a later phase. The state is a list of document ids, newest
/// first.
class ScannerHistoryNotifier extends AsyncNotifier<List<String>> {
  final LocalScannerRepository _repository = LocalScannerRepository();

  @override
  Future<List<String>> build() async => const [];

  /// Adds [documentId] to the top of the history list.
  ///
  /// The id must correspond to an existing document. If it does
  /// not, the history is left unchanged.
  Future<void> addToHistory(String documentId) async {
    state = const AsyncLoading();

    try {
      final existing = await _repository.getDocument(documentId);
      if (existing == null) {
        final current = state.valueOrNull ?? const [];
        state = AsyncData(current);
        return;
      }

      final current = state.valueOrNull ?? const <String>[];
      final updated = <String>[
        documentId,
        ...current.where((id) => id != documentId),
      ];
      state = AsyncData(updated);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Clears the in-memory history.
  Future<void> clearHistory() async {
    state = const AsyncData([]);
  }

  /// Reloads the history. In Phase 5 this simply resets to empty
  /// because persistence is not implemented.
  Future<void> loadHistory() async {
    state = const AsyncData([]);
  }
}

final scannerHistoryProvider =
    AsyncNotifierProvider<ScannerHistoryNotifier, List<String>>(
  ScannerHistoryNotifier.new,
);
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/recent_procedures_service.dart';

/// In-memory state of recently-viewed procedure IDs, newest-first.
///
/// Loads persisted history once asynchronously during [build]. Records
/// visits synchronously so the UI reacts immediately, then persists.
/// A guard prevents a stale async load from overwriting state that was
/// produced by a real user action before the load returned.
class RecentProceduresNotifier extends Notifier<List<String>> {
  bool _userMutated = false;

  @override
  List<String> build() {
    _loadPersisted();
    return const <String>[];
  }

  Future<void> _loadPersisted() async {
    final persisted =
        await RecentProceduresService.getRecentProcedureIds();

    if (_userMutated) return;

    try {
      state = persisted;
    } catch (_) {
      // Notifier disposed while awaiting - nothing to do.
    }
  }

  /// Records a visit to the procedure with the given [procedureId].
  ///
  /// Ignores empty ids. Moves an existing id to the top, otherwise
  /// prepends. Trims to [RecentProceduresService.maxEntries].
  void recordVisit(String procedureId) {
    final normalized = procedureId.trim();
    if (normalized.isEmpty) return;

    _userMutated = true;

    final updated = <String>[
      normalized,
      ...state.where((id) => id != normalized),
    ];

    if (updated.length > RecentProceduresService.maxEntries) {
      updated.removeRange(
        RecentProceduresService.maxEntries,
        updated.length,
      );
    }

    state = updated;

    RecentProceduresService.saveRecentProcedureIds(updated);
  }
}

final recentProceduresProvider =
    NotifierProvider<RecentProceduresNotifier, List<String>>(
  RecentProceduresNotifier.new,
);
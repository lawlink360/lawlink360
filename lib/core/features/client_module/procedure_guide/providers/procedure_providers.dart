import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/procedure_data.dart';
import '../models/procedure_model.dart';

/// Holds the current search query entered by the user.
///
/// Empty string means "no active search". This is intentionally a
/// simple synchronous Notifier — Procedure Guide data is static and
/// local for this phase, so no async architecture is required.
class ProcedureSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String value) {
    state = value;
  }

  void clear() {
    state = '';
  }
}

final procedureSearchProvider =
    NotifierProvider<ProcedureSearchNotifier, String>(
  ProcedureSearchNotifier.new,
);

/// Exposes the full static procedure list.
///
/// This exists only so the filtered provider below has a stable
/// dependency. It does not duplicate `ProcedureData.procedures`.
final allProceduresProvider = Provider<List<ProcedureModel>>((ref) {
  return ProcedureData.procedures;
});

/// Returns the procedures that match the current search query.
///
/// Matching is case-insensitive and checks:
///   * title
///   * overview
///   * applicable laws
///
/// When the query is empty, the full list is returned so the
/// category-based home UI continues to behave as before.
final filteredProceduresProvider = Provider<List<ProcedureModel>>((ref) {
  final query = ref.watch(procedureSearchProvider).trim().toLowerCase();
  final all = ref.watch(allProceduresProvider);

  if (query.isEmpty) return all;

  return all.where((procedure) {
    if (procedure.title.toLowerCase().contains(query)) return true;
    if (procedure.overview.toLowerCase().contains(query)) return true;
    for (final law in procedure.applicableLaws) {
      if (law.toLowerCase().contains(query)) return true;
    }
    return false;
  }).toList(growable: false);
});
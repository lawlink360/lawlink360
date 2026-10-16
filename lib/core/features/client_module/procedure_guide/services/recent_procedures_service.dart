import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Persistence for the Procedure Guide's recently-viewed procedure IDs.
///
/// Stores only a list of unique [ProcedureModel.id] strings, newest-first.
/// Does not resolve templates or read procedure data; that is the provider's
/// responsibility. Uses SharedPreferences, which is already a project
/// dependency.
class RecentProceduresService {
  RecentProceduresService._();

  static const String _storageKey =
      'procedure_guide_recent_procedures_v1';

  /// Maximum number of unique procedure IDs retained in storage.
  static const int maxEntries = 20;

  /// Returns the persisted list of procedure IDs, newest-first.
  ///
  /// Never throws. On any read or decode error, returns an empty list.
  static Future<List<String>> getRecentProcedureIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw == null || raw.isEmpty) return const <String>[];

      final decoded = jsonDecode(raw);
      if (decoded is! List) return const <String>[];

      final ids = <String>[];
      for (final item in decoded) {
        if (item is String && item.isNotEmpty) {
          ids.add(item);
        }
      }
      return ids;
    } catch (_) {
      return const <String>[];
    }
  }

  /// Persists the given list of procedure IDs, newest-first.
  ///
  /// Trims to [maxEntries]. Never throws.
  static Future<void> saveRecentProcedureIds(List<String> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final trimmed = ids.length > maxEntries
          ? ids.sublist(0, maxEntries)
          : ids;
      await prefs.setString(_storageKey, jsonEncode(trimmed));
    } catch (_) {
      // Swallow. Persistence failure must not break the UI.
    }
  }
}
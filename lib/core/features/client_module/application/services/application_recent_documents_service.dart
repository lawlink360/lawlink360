import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// ============================================================
/// APPLICATION RECENT DOCUMENTS SERVICE
/// ============================================================
///
/// Persistence-only service for the Application feature's
/// "Recent Documents" list.
///
/// Responsibilities:
///   - persist a small ordered history of recently visited
///     template IDs together with a visit timestamp;
///   - expose the history to the future Riverpod notifier.
///
/// Non-responsibilities (enforced by design):
///   - no Riverpod;
///   - no UI;
///   - no navigation;
///   - no Firebase / Firestore;
///   - does not resolve DocumentTemplate objects;
///   - does not read DocumentJsonService / DocumentDataService.
///
/// Storage format:
///   SharedPreferences key "application_recent_documents" holds a
///   single JSON-encoded String. The JSON value is a list of maps:
///
///     [
///       { "templateId": "tpl_xxx", "visitedAt": "2026-10-07T12:34:56.789Z" },
///       ...
///     ]
///
///   Order is newest-first. Only [templateId] and [visitedAt] are
///   stored; no other template metadata is persisted.
///
/// History policy:
///   - maximum 50 entries;
///   - re-visiting an existing template moves it to the top
///     (deduplicated by templateId).
///
/// Robustness policy:
///   - any decode / parse failure is swallowed and treated as
///     "no history", so the Application feature never crashes
///     because of persisted data;
///   - individual malformed entries are dropped silently.
/// ============================================================

/// Immutable entry representing a single recent-document visit.
class RecentDocumentEntry {
  final String templateId;
  final DateTime visitedAt;

  const RecentDocumentEntry({
    required this.templateId,
    required this.visitedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'templateId': templateId,
      'visitedAt': visitedAt.toUtc().toIso8601String(),
    };
  }

  static RecentDocumentEntry? tryFromJson(dynamic raw) {
    if (raw is! Map) return null;

    final templateId = raw['templateId'];
    final visitedAtRaw = raw['visitedAt'];

    if (templateId is! String || templateId.isEmpty) return null;
    if (visitedAtRaw is! String) return null;

    final parsed = DateTime.tryParse(visitedAtRaw);
    if (parsed == null) return null;

    return RecentDocumentEntry(
      templateId: templateId,
      visitedAt: parsed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentDocumentEntry &&
          runtimeType == other.runtimeType &&
          templateId == other.templateId &&
          visitedAt == other.visitedAt);

  @override
  int get hashCode => Object.hash(templateId, visitedAt);

  @override
  String toString() =>
      'RecentDocumentEntry(templateId: $templateId, visitedAt: $visitedAt)';
}

/// Static persistence service for Application → Recent Documents.
class ApplicationRecentDocumentsService {
  ApplicationRecentDocumentsService._();

  /// Maximum number of entries kept in the history.
  static const int maxEntries = 50;

  /// SharedPreferences key that owns the persisted history.
  static const String _storageKey = 'application_recent_documents';

  /// Records a visit to the template with the given [templateId].
  ///
  /// Behavior:
  ///   - ignores empty / whitespace-only template IDs;
  ///   - loads existing history;
  ///   - removes any existing entry with the same templateId;
  ///   - inserts the new entry at the top;
  ///   - trims the list to [maxEntries];
  ///   - persists the updated list.
  static Future<void> recordVisit(String templateId) async {
    final normalized = templateId.trim();
    if (normalized.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = _read(prefs);

      final updated = <RecentDocumentEntry>[
        RecentDocumentEntry(
          templateId: normalized,
          visitedAt: DateTime.now().toUtc(),
        ),
        ...existing.where((e) => e.templateId != normalized),
      ];

      if (updated.length > maxEntries) {
        updated.removeRange(maxEntries, updated.length);
      }

      await _write(prefs, updated);
    } catch (_) {
      // Persistence failures must not crash the Application feature.
    }
  }

  /// Removes the entries whose templateId is in [templateIds].
  ///
  /// Behavior:
  ///   - ignores an empty id set;
  ///   - loads existing history;
  ///   - keeps only entries whose templateId is NOT in the set;
  ///   - persists the resulting list.
  ///
  /// Deletion affects only the Recent Documents history; it does
  /// not touch templates or document content.
  static Future<void> removeEntries(Set<String> templateIds) async {
    if (templateIds.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final existing = _read(prefs);

      final filtered = existing
          .where((e) => !templateIds.contains(e.templateId))
          .toList();

      await _write(prefs, filtered);
    } catch (_) {
      // Persistence failures must not crash the Application feature.
    }
  }

  /// Returns the stored recent-document entries in newest → oldest order.
  ///
  /// Returns an empty list if nothing is stored or if the stored value
  /// cannot be decoded safely.
  static Future<List<RecentDocumentEntry>> getRecentDocuments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return _read(prefs);
    } catch (_) {
      return const <RecentDocumentEntry>[];
    }
  }

  /// Removes all stored recent-document history.
  static Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (_) {
      // Swallow - clearing history must not crash the app.
    }
  }

  // ============================================================
  // INTERNAL HELPERS
  // ============================================================

  static List<RecentDocumentEntry> _read(SharedPreferences prefs) {
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return const <RecentDocumentEntry>[];

    dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } catch (_) {
      return const <RecentDocumentEntry>[];
    }

    if (decoded is! List) return const <RecentDocumentEntry>[];

    final entries = <RecentDocumentEntry>[];
    for (final item in decoded) {
      final entry = RecentDocumentEntry.tryFromJson(item);
      if (entry != null) entries.add(entry);
      if (entries.length >= maxEntries) break;
    }

    return entries;
  }

  static Future<void> _write(
    SharedPreferences prefs,
    List<RecentDocumentEntry> entries,
  ) async {
    final encoded = jsonEncode(
      entries.map((e) => e.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encoded);
  }
}
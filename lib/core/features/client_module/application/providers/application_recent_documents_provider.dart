import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/application_recent_documents_service.dart';

/// ============================================================
/// APPLICATION RECENT DOCUMENTS — RIVERPOD LAYER
/// ============================================================
///
/// State layer between the Application UI and
/// [ApplicationRecentDocumentsService].
///
/// Architecture:
///   DocumentPreviewScreen
///     -> recentDocumentsProvider
///     -> ApplicationRecentDocumentsNotifier
///     -> ApplicationRecentDocumentsService
///     -> SharedPreferences
///
/// Follows the existing LawLink360 Riverpod style established by
/// notification_provider.dart: NotifierProvider + Notifier List T>.
///
/// This notifier:
///   - owns the in-memory list of [RecentDocumentEntry];
///   - loads persisted history once, asynchronously, at build();
///   - updates state synchronously when a visit is recorded or the
///     history is cleared, so the UI reacts immediately;
///   - delegates persistence to the service (no SharedPreferences
///     logic lives here).
///
/// It does NOT:
///   - resolve DocumentTemplate objects;
///   - read DocumentJsonService / DocumentDataService;
///   - touch Firestore;
///   - render UI.
/// ============================================================

final recentDocumentsProvider = NotifierProvider<
    ApplicationRecentDocumentsNotifier, List<RecentDocumentEntry>>(
  ApplicationRecentDocumentsNotifier.new,
);

class ApplicationRecentDocumentsNotifier
    extends Notifier<List<RecentDocumentEntry>> {
  /// Guards against a stale async initialization overwriting a
  /// state that was produced by a real user action before the
  /// initialization result arrived.
  ///
  /// Set to true the moment a user-driven mutation
  /// (`recordVisit` / `clear` / `deleteEntries`) updates `state`.
  /// Once true, the initialization result is discarded.
  bool _userMutated = false;

  @override
  List<RecentDocumentEntry> build() {
    // Kick off async load without changing the synchronous state
    // type. Start with a safe empty list; replace it when the
    // persisted history arrives — unless the user has already
    // mutated state in the meantime.
    _loadPersistedHistory();
    return const <RecentDocumentEntry>[];
  }

  Future<void> _loadPersistedHistory() async {
    final persisted =
        await ApplicationRecentDocumentsService.getRecentDocuments();

    // Discard a stale async result if the user already acted.
    if (_userMutated) return;

    // If the notifier was disposed while awaiting, assigning to
    // `state` throws. Swallow that specific case; it is expected
    // and not a real error.
    try {
      state = persisted;
    } catch (_) {
      // Notifier already disposed - nothing to do.
    }
  }

  /// Records a visit to the template with the given [templateId].
  ///
  /// Behavior:
  ///   - ignores empty / whitespace-only IDs;
  ///   - updates in-memory state immediately so the UI reacts;
  ///   - deduplicates by templateId, newest at the top;
  ///   - trims the list to the service's max (50) entries;
  ///   - persists via [ApplicationRecentDocumentsService.recordVisit].
  void recordVisit(String templateId) {
    final normalized = templateId.trim();
    if (normalized.isEmpty) return;

    _userMutated = true;

    final updated = <RecentDocumentEntry>[
      RecentDocumentEntry(
        templateId: normalized,
        visitedAt: DateTime.now().toUtc(),
      ),
      ...state.where((e) => e.templateId != normalized),
    ];

    final max = ApplicationRecentDocumentsService.maxEntries;
    if (updated.length > max) {
      updated.removeRange(max, updated.length);
    }

    state = updated;

    // Fire-and-forget persistence; the service swallows failures.
    ApplicationRecentDocumentsService.recordVisit(normalized);
  }

  /// Removes the entries whose templateId is in [templateIds] from
  /// in-memory state and persists the deletion.
  ///
  /// Behavior:
  ///   - ignores an empty id set;
  ///   - updates in-memory state immediately so the UI reacts;
  ///   - persists via [ApplicationRecentDocumentsService.removeEntries].
  void deleteEntries(Set<String> templateIds) {
    if (templateIds.isEmpty) return;

    _userMutated = true;

    state = state
        .where((e) => !templateIds.contains(e.templateId))
        .toList();

    // Fire-and-forget persistence; the service swallows failures.
    ApplicationRecentDocumentsService.removeEntries(templateIds);
  }

  /// Clears in-memory state immediately and persists the clear.
  void clear() {
    _userMutated = true;

    state = const <RecentDocumentEntry>[];

    // Fire-and-forget persistence; the service swallows failures.
    ApplicationRecentDocumentsService.clear();
  }
}
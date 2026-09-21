import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/scanner_page.dart';
import '../services/scanner_storage_service.dart';

/// Immutable state exposed by [ScannerPagesNotifier].
class ScannerPagesState {
  const ScannerPagesState({
    this.pages = const [],
    this.activePageIndex = 0,
  });

  final List<ScannerPage> pages;
  final int activePageIndex;

  ScannerPagesState copyWith({
    List<ScannerPage>? pages,
    int? activePageIndex,
  }) {
    final nextPages = pages ?? this.pages;
    final rawIndex = activePageIndex ?? this.activePageIndex;
    final clamped = nextPages.isEmpty
        ? 0
        : rawIndex.clamp(0, nextPages.length - 1);
    return ScannerPagesState(
      pages: nextPages,
      activePageIndex: clamped,
    );
  }
}

/// Manages the ordered list of [ScannerPage] in the current
/// session and the currently active page index.
///
/// Phase 5 does not sync this list to `ScannerSession.pages`.
/// Pages live only here. The caller composes a full session at
/// export time.
///
/// Phase 9 Batch 9.6 — `clearPages` performs session-scoped
/// cleanup after a successful save: it resets the page state and
/// deletes the entire `scanner_360/sessions/<sessionId>/`
/// directory. `removePage` remains page-level cleanup.
///
/// Phase 9 Batch 9.7 — `resetForNewSession` is the start-of-session
/// reset used by `ScannerHomeScreen` before a new scan begins. It
/// resets page state and cleans the previous session's assets if a
/// previous session id is supplied.
///
/// Phase 9 Batch 9.9 — `clearPages` now performs storage deletion
/// before resetting the page state, so a failed deletion leaves
/// the pages provider intact and allows the caller to recover.
class ScannerPagesNotifier extends Notifier<ScannerPagesState> {
  final ScannerStorageService _storage = const ScannerStorageService();

  @override
  ScannerPagesState build() => const ScannerPagesState();

  /// Appends [page] and sets it as the active page.
  void addPage(ScannerPage page) {
    final updated = [...state.pages, page];
    state = state.copyWith(
      pages: updated,
      activePageIndex: updated.length - 1,
    );
  }

  /// Removes the page at [index] and deletes its files.
  Future<void> removePage(int index) async {
    if (index < 0 || index >= state.pages.length) return;

    final page = state.pages[index];
    final updated = List<ScannerPage>.from(state.pages)..removeAt(index);

    state = state.copyWith(pages: updated);

    await _storage.deletePageFiles(
      pageId: page.id,
      imagePath: page.imagePath,
      thumbnailPath: page.thumbnailPath,
    );
  }

  /// Moves the page at [oldIndex] to [newIndex].
  void reorderPages(int oldIndex, int newIndex) {
    if (oldIndex < 0 || oldIndex >= state.pages.length) return;
    if (newIndex < 0 || newIndex > state.pages.length) return;
    if (oldIndex == newIndex) return;

    final updated = List<ScannerPage>.from(state.pages);
    final page = updated.removeAt(oldIndex);
    final adjusted = newIndex > oldIndex ? newIndex - 1 : newIndex;
    updated.insert(adjusted, page);

    state = state.copyWith(
      pages: updated,
      activePageIndex: adjusted,
    );
  }

  /// Sets the active page index. Clamped to valid range.
  void setActivePage(int index) {
    state = state.copyWith(activePageIndex: index);
  }

  /// Replaces the page at [index] with [page].
  void replacePage(int index, ScannerPage page) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScannerPage>.from(state.pages);
    updated[index] = page;
    state = state.copyWith(pages: updated);
  }

  /// Resets page state and deletes the entire session asset
  /// directory for [sessionId].
  ///
  /// This is session-scoped cleanup performed after a successful
  /// save. It removes `scanner_360/sessions/<sessionId>/`
  /// recursively through [ScannerStorageService.deleteSessionAssets].
  ///
  /// Storage deletion is performed first. If it throws, the
  /// exception propagates and the pages provider state is left
  /// intact, so the caller can recover.
  ///
  /// Document-owned assets under `scanner_360/documents/` are
  /// unaffected.
  Future<void> clearPages({required String sessionId}) async {
    await _storage.deleteSessionAssets(sessionId: sessionId);
    state = const ScannerPagesState();
  }

  /// Resets page state when a new scanning session is about to
  /// start.
  ///
  /// Guarantees the invariant:
  ///
  ///     NEW SESSION ⇒ scannerPagesProvider starts empty
  ///
  /// If [previousSessionId] is supplied and non-empty, that
  /// session's assets are deleted through
  /// [ScannerStorageService.deleteSessionAssets] **before** the
  /// page state is reset. The previous session id is used
  /// verbatim; the new session's id is never passed here, so the
  /// new session's assets cannot be affected.
  ///
  /// If [previousSessionId] is null or empty, no assets are
  /// deleted — only the page state is reset.
  Future<void> resetForNewSession({
    String? previousSessionId,
  }) async {
    if (previousSessionId != null && previousSessionId.isNotEmpty) {
      await _storage.deleteSessionAssets(
        sessionId: previousSessionId,
      );
    }
    state = const ScannerPagesState();
  }
}

final scannerPagesProvider =
    NotifierProvider<ScannerPagesNotifier, ScannerPagesState>(
  ScannerPagesNotifier.new,
);
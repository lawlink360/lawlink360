import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/law_model.dart';
import '../services/law_bookmark_service.dart';
import 'law_provider.dart';

final lawBookmarkServiceProvider =
    Provider<LawBookmarkService>((ref) {
  return LawBookmarkService();
});

final lawBookmarkProvider = StateNotifierProvider<
    LawBookmarkNotifier, LawBookmarkState>((ref) {
  final service = ref.watch(lawBookmarkServiceProvider);
  final lawState = ref.watch(lawProvider);

  return LawBookmarkNotifier(
    service: service,
    allLaws: lawState.laws,
  );
});

class LawBookmarkNotifier
    extends StateNotifier<LawBookmarkState> {
  LawBookmarkNotifier({
    required LawBookmarkService service,
    required List<LawModel> allLaws,
  })  : _service = service,
        _allLaws = allLaws,
        super(const LawBookmarkState()) {
    _loadBookmarks();
  }

  final LawBookmarkService _service;

  List<LawModel> _allLaws;

  /// Updates the available law list.
  void updateLaws(List<LawModel> laws) {
    _allLaws = laws;
    _loadBookmarks();
  }

  /// Loads bookmarks from the bookmark service.
  void _loadBookmarks() {
    final bookmarkedIds = _service.bookmarkedLawIds;

    final bookmarkedLaws = _service.getBookmarkedLaws(
      _allLaws,
    );

    state = state.copyWith(
      bookmarkedLawIds: bookmarkedIds,
      bookmarkedLaws: bookmarkedLaws,
      bookmarkCount: bookmarkedIds.length,
    );
  }

  /// Checks whether a law is bookmarked.
  bool isBookmarked(String lawId) {
    return _service.isBookmarked(lawId);
  }

  /// Adds a law to bookmarks.
  void addBookmark(LawModel law) {
    _service.addBookmark(law);
    _loadBookmarks();
  }

  /// Removes a law from bookmarks.
  void removeBookmark(String lawId) {
    _service.removeBookmark(lawId);
    _loadBookmarks();
  }

  /// Toggles bookmark state.
  void toggleBookmark(LawModel law) {
    _service.toggleBookmark(law);
    _loadBookmarks();
  }

  /// Clears all bookmarks.
  void clearBookmarks() {
    _service.clearBookmarks();
    _loadBookmarks();
  }
}

class LawBookmarkState {
  const LawBookmarkState({
    this.bookmarkedLawIds = const {},
    this.bookmarkedLaws = const [],
    this.bookmarkCount = 0,
  });

  final Set<String> bookmarkedLawIds;
  final List<LawModel> bookmarkedLaws;
  final int bookmarkCount;

  bool isBookmarked(String lawId) {
    return bookmarkedLawIds.contains(lawId);
  }

  LawBookmarkState copyWith({
    Set<String>? bookmarkedLawIds,
    List<LawModel>? bookmarkedLaws,
    int? bookmarkCount,
  }) {
    return LawBookmarkState(
      bookmarkedLawIds:
          bookmarkedLawIds ?? this.bookmarkedLawIds,
      bookmarkedLaws:
          bookmarkedLaws ?? this.bookmarkedLaws,
      bookmarkCount:
          bookmarkCount ?? this.bookmarkCount,
    );
  }
}
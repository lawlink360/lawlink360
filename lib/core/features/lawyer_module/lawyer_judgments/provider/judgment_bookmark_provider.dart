import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/judgment_model.dart';
import '../services/judgment_bookmark_service.dart';
import 'judgment_provider.dart';

final judgmentBookmarkServiceProvider =
    Provider<JudgmentBookmarkService>((ref) {
  return JudgmentBookmarkService();
});

final judgmentBookmarkProvider =
    NotifierProvider<JudgmentBookmarkNotifier, List<JudgmentModel>>(
  JudgmentBookmarkNotifier.new,
);

final isJudgmentBookmarkedProvider =
    Provider.family<bool, String>((ref, judgmentId) {
  final bookmarkedJudgments = ref.watch(judgmentBookmarkProvider);

  return bookmarkedJudgments.any(
    (judgment) => judgment.id == judgmentId,
  );
});

class JudgmentBookmarkNotifier extends Notifier<List<JudgmentModel>> {
  late final JudgmentBookmarkService _bookmarkService;

  @override
  List<JudgmentModel> build() {
    _bookmarkService = ref.watch(judgmentBookmarkServiceProvider);
    return _getBookmarkedJudgments();
  }

  void toggleBookmark(String judgmentId) {
    _bookmarkService.toggleBookmark(judgmentId);
    state = _getBookmarkedJudgments();
  }

  void addBookmark(String judgmentId) {
    _bookmarkService.addBookmark(judgmentId);
    state = _getBookmarkedJudgments();
  }

  void removeBookmark(String judgmentId) {
    _bookmarkService.removeBookmark(judgmentId);
    state = _getBookmarkedJudgments();
  }

  bool isBookmarked(String judgmentId) {
    return _bookmarkService.isBookmarked(judgmentId);
  }

  void clearBookmarks() {
    _bookmarkService.clearBookmarks();
    state = [];
  }

  List<JudgmentModel> _getBookmarkedJudgments() {
    final judgmentService = ref.read(judgmentServiceProvider);
    final bookmarkedIds = _bookmarkService.getBookmarkedIds();

    return bookmarkedIds
        .map(judgmentService.getJudgmentById)
        .whereType<JudgmentModel>()
        .toList();
  }
}
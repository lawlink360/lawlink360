class JudgmentBookmarkService {
  final Set<String> _bookmarkedJudgmentIds = {};

  bool isBookmarked(String judgmentId) {
    return _bookmarkedJudgmentIds.contains(judgmentId);
  }

  void addBookmark(String judgmentId) {
    _bookmarkedJudgmentIds.add(judgmentId);
  }

  void removeBookmark(String judgmentId) {
    _bookmarkedJudgmentIds.remove(judgmentId);
  }

  void toggleBookmark(String judgmentId) {
    if (isBookmarked(judgmentId)) {
      removeBookmark(judgmentId);
    } else {
      addBookmark(judgmentId);
    }
  }

  List<String> getBookmarkedIds() {
    return _bookmarkedJudgmentIds.toList();
  }

  void clearBookmarks() {
    _bookmarkedJudgmentIds.clear();
  }
}
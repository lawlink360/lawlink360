import '../models/law_model.dart';

class LawBookmarkService {
  LawBookmarkService();

  final Set<String> _bookmarkedLawIds = <String>{};

  /// Returns all bookmarked law IDs.
  Set<String> get bookmarkedLawIds {
    return Set<String>.unmodifiable(_bookmarkedLawIds);
  }

  /// Checks whether a law is bookmarked.
  bool isBookmarked(String lawId) {
    return _bookmarkedLawIds.contains(lawId);
  }

  /// Adds a law to bookmarks.
  void addBookmark(LawModel law) {
    _bookmarkedLawIds.add(law.id);
  }

  /// Removes a law from bookmarks.
  void removeBookmark(String lawId) {
    _bookmarkedLawIds.remove(lawId);
  }

  /// Toggles bookmark state.
  bool toggleBookmark(LawModel law) {
    if (isBookmarked(law.id)) {
      removeBookmark(law.id);
      return false;
    }

    addBookmark(law);
    return true;
  }

  /// Returns the complete bookmarked law objects.
  List<LawModel> getBookmarkedLaws(
    List<LawModel> allLaws,
  ) {
    return allLaws.where((law) {
      return _bookmarkedLawIds.contains(law.id);
    }).toList();
  }

  /// Returns the number of bookmarked laws.
  int getBookmarkCount() {
    return _bookmarkedLawIds.length;
  }

  /// Removes all bookmarks.
  void clearBookmarks() {
    _bookmarkedLawIds.clear();
  }
}
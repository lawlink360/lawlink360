import '../data/law_data.dart';
import '../models/law_model.dart';

class LawSearchService {
  const LawSearchService();

  /// Searches the complete law library.
  ///
  /// Searches through:
  /// - Law title
  /// - Short title
  /// - Description
  /// - Category name
  /// - Year
  List<LawModel> search(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return [];
    }

    return LawData.laws.where((law) {
      final title = law.title.toLowerCase();
      final shortTitle = law.shortTitle.toLowerCase();
      final description = law.description.toLowerCase();
      final category = law.categoryName.toLowerCase();
      final year = law.year.toString();

      return title.contains(normalizedQuery) ||
          shortTitle.contains(normalizedQuery) ||
          description.contains(normalizedQuery) ||
          category.contains(normalizedQuery) ||
          year.contains(normalizedQuery);
    }).toList();
  }

  /// Searches laws within a specific category.
  List<LawModel> searchByCategory({
    required String query,
    required String categoryId,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    final categoryLaws = LawData.getByCategory(categoryId);

    if (normalizedQuery.isEmpty) {
      return categoryLaws;
    }

    return categoryLaws.where((law) {
      final title = law.title.toLowerCase();
      final shortTitle = law.shortTitle.toLowerCase();
      final description = law.description.toLowerCase();

      return title.contains(normalizedQuery) ||
          shortTitle.contains(normalizedQuery) ||
          description.contains(normalizedQuery);
    }).toList();
  }

  /// Returns laws matching a specific year.
  List<LawModel> searchByYear(int year) {
    return LawData.laws.where((law) {
      return law.year == year;
    }).toList();
  }

  /// Returns laws matching a specific category.
  List<LawModel> searchByCategoryId(String categoryId) {
    return LawData.getByCategory(categoryId);
  }

  /// Returns laws beginning with a specific letter.
  List<LawModel> searchByLetter(String letter) {
    final normalizedLetter = letter.trim().toLowerCase();

    if (normalizedLetter.isEmpty) {
      return [];
    }

    return LawData.laws.where((law) {
      return law.title
          .trim()
          .toLowerCase()
          .startsWith(normalizedLetter);
    }).toList();
  }

  /// Returns suggestions while the lawyer is typing.
  ///
  /// Suggestions are based primarily on the law title
  /// and short title.
  List<LawModel> getSuggestions(
    String query, {
    int limit = 8,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty || limit <= 0) {
      return [];
    }

    final suggestions = LawData.laws.where((law) {
      final title = law.title.toLowerCase();
      final shortTitle = law.shortTitle.toLowerCase();

      return title.startsWith(normalizedQuery) ||
          shortTitle.startsWith(normalizedQuery);
    }).toList();

    return suggestions.take(limit).toList();
  }
}
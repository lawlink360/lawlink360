import '../data/law_data.dart';
import '../models/law_model.dart';

class LawService {
  const LawService();

  /// Returns all available laws.
  List<LawModel> getAllLaws() {
    return List<LawModel>.from(LawData.laws);
  }

  /// Returns a law by its unique ID.
  LawModel? getLawById(String lawId) {
    for (final law in LawData.laws) {
      if (law.id == lawId) {
        return law;
      }
    }

    return null;
  }

  /// Returns laws belonging to a specific category.
  List<LawModel> getLawsByCategory(String categoryId) {
    return LawData.getByCategory(categoryId);
  }

  /// Returns laws beginning with a specific letter.
  List<LawModel> getLawsByLetter(String letter) {
    final normalizedLetter = letter.trim().toLowerCase();

    if (normalizedLetter.isEmpty) {
      return [];
    }

    return LawData.laws.where((law) {
      final title = law.title.trim().toLowerCase();

      return title.startsWith(normalizedLetter);
    }).toList();
  }

  /// Returns featured laws.
  ///
  /// This currently returns the first few laws from
  /// the local data source. Later this can be replaced
  /// by a featured/priority field from Firestore.
  List<LawModel> getFeaturedLaws({
    int limit = 5,
  }) {
    if (limit <= 0) {
      return [];
    }

    return LawData.laws.take(limit).toList();
  }

  /// Returns the total number of laws.
  int getLawCount() {
    return LawData.laws.length;
  }
}
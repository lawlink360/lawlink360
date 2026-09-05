import '../models/judgment_model.dart';

class JudgmentSearchService {
  List<JudgmentModel> search({
    required List<JudgmentModel> judgments,
    String query = '',
    String? court,
    String? category,
    String? lawReport,
  }) {
    final normalizedQuery = query.trim().toLowerCase();

    return judgments.where((judgment) {
      final matchesQuery =
          normalizedQuery.isEmpty ||
          judgment.title.toLowerCase().contains(normalizedQuery) ||
          judgment.citation.toLowerCase().contains(normalizedQuery) ||
          judgment.court.toLowerCase().contains(normalizedQuery) ||
          judgment.caseNumber.toLowerCase().contains(normalizedQuery) ||
          judgment.category.toLowerCase().contains(normalizedQuery) ||
          judgment.summary.toLowerCase().contains(normalizedQuery) ||
          judgment.judges.toLowerCase().contains(normalizedQuery) ||
          judgment.judgmentText.toLowerCase().contains(normalizedQuery) ||
          judgment.keywords.any(
            (keyword) => keyword.toLowerCase().contains(normalizedQuery),
          ) ||
          judgment.relevantLaws.any(
            (law) => law.toLowerCase().contains(normalizedQuery),
          );

      final matchesCourt =
          court == null ||
          court.isEmpty ||
          judgment.court.toLowerCase() == court.toLowerCase();

      final matchesCategory =
          category == null ||
          category.isEmpty ||
          judgment.category.toLowerCase() == category.toLowerCase();

      final matchesLawReport =
          lawReport == null ||
          lawReport.isEmpty ||
          judgment.citation
              .toLowerCase()
              .startsWith(lawReport.toLowerCase());

      return matchesQuery &&
          matchesCourt &&
          matchesCategory &&
          matchesLawReport;
    }).toList();
  }
}
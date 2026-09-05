import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/judgment_index_data.dart';
import '../models/judgment_model.dart';

final judgmentServiceProvider = Provider<JudgmentService>((ref) {
  return JudgmentService();
});

class JudgmentService {
  List<JudgmentModel> getAllJudgments() {
    return JudgmentIndexData.judgments;
  }

  JudgmentModel? getJudgmentById(String id) {
    try {
      return JudgmentIndexData.judgments.firstWhere(
        (judgment) => judgment.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  List<JudgmentModel> getJudgmentsByCourt(String court) {
    return JudgmentIndexData.judgments
        .where(
          (judgment) =>
              judgment.court.toLowerCase() == court.toLowerCase(),
        )
        .toList();
  }

  List<JudgmentModel> getJudgmentsByCategory(String category) {
    return JudgmentIndexData.judgments
        .where(
          (judgment) =>
              judgment.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }

  List<JudgmentModel> getJudgmentsByLaw(String law) {
    return JudgmentIndexData.judgments
        .where(
          (judgment) => judgment.relevantLaws.any(
            (item) => item.toLowerCase().contains(
                  law.toLowerCase(),
                ),
          ),
        )
        .toList();
  }

  List<JudgmentModel> getRecentJudgments({
    int limit = 5,
  }) {
    final judgments = [
      ...JudgmentIndexData.judgments,
    ];

    return judgments.take(limit).toList();
  }
}
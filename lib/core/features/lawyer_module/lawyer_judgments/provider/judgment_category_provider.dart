import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/judgment_index_data.dart';
import '../models/judgment_model.dart';
import 'judgment_provider.dart';

final judgmentCourtsProvider = Provider<List<String>>((ref) {
  return JudgmentIndexData.courts;
});

final judgmentCategoriesProvider = Provider<List<String>>((ref) {
  return JudgmentIndexData.categories;
});

final judgmentLawReportsProvider = Provider<List<String>>((ref) {
  return JudgmentIndexData.lawReports;
});

final judgmentsByCourtProvider =
    Provider.family<List<JudgmentModel>, String>((ref, court) {
  final judgmentNotifier = ref.read(judgmentProvider.notifier);
  return judgmentNotifier.getJudgmentsByCourt(court);
});

final judgmentsByCategoryProvider =
    Provider.family<List<JudgmentModel>, String>((ref, category) {
  final judgmentNotifier = ref.read(judgmentProvider.notifier);
  return judgmentNotifier.getJudgmentsByCategory(category);
});

final judgmentsByLawProvider =
    Provider.family<List<JudgmentModel>, String>((ref, law) {
  final judgmentNotifier = ref.read(judgmentProvider.notifier);
  return judgmentNotifier.getJudgmentsByLaw(law);
});
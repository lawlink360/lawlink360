import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/judgment_model.dart';
import '../services/judgment_service.dart';

final judgmentServiceProvider = Provider<JudgmentService>((ref) {
  return JudgmentService();
});

final judgmentProvider =
    NotifierProvider<JudgmentNotifier, List<JudgmentModel>>(
  JudgmentNotifier.new,
);

class JudgmentNotifier extends Notifier<List<JudgmentModel>> {
  @override
  List<JudgmentModel> build() {
    final judgmentService = ref.watch(judgmentServiceProvider);
    return judgmentService.getAllJudgments();
  }

  JudgmentModel? getJudgmentById(String id) {
    final judgmentService = ref.read(judgmentServiceProvider);
    return judgmentService.getJudgmentById(id);
  }

  List<JudgmentModel> getJudgmentsByCourt(String court) {
    final judgmentService = ref.read(judgmentServiceProvider);
    return judgmentService.getJudgmentsByCourt(court);
  }

  List<JudgmentModel> getJudgmentsByCategory(String category) {
    final judgmentService = ref.read(judgmentServiceProvider);
    return judgmentService.getJudgmentsByCategory(category);
  }

  List<JudgmentModel> getJudgmentsByLaw(String law) {
    final judgmentService = ref.read(judgmentServiceProvider);
    return judgmentService.getJudgmentsByLaw(law);
  }
}
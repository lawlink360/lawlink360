import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/judgment_model.dart';
import '../services/judgment_service.dart';

final judgmentRecentProvider =
    StateNotifierProvider<JudgmentRecentNotifier, List<JudgmentModel>>(
  (ref) {
    final judgmentService = ref.watch(judgmentServiceProvider);

    return JudgmentRecentNotifier(judgmentService);
  },
);

class JudgmentRecentNotifier extends StateNotifier<List<JudgmentModel>> {
  final JudgmentService _judgmentService;

  JudgmentRecentNotifier(this._judgmentService)
      : super(_judgmentService.getRecentJudgments());

  void refresh() {
    state = _judgmentService.getRecentJudgments();
  }
}
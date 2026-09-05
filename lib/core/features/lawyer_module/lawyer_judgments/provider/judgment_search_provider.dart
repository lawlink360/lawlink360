import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/judgment_model.dart';
import '../services/judgment_search_service.dart';
import 'judgment_provider.dart';

final judgmentSearchServiceProvider =
    Provider<JudgmentSearchService>((ref) {
  return JudgmentSearchService();
});

final judgmentSearchProvider =
    NotifierProvider<JudgmentSearchNotifier, List<JudgmentModel>>(
  JudgmentSearchNotifier.new,
);

class JudgmentSearchNotifier extends Notifier<List<JudgmentModel>> {
  @override
  List<JudgmentModel> build() {
    return ref.watch(judgmentProvider);
  }

  void search({
    String query = '',
    String? court,
    String? category,
    String? lawReport,
  }) {
    final searchService = ref.read(judgmentSearchServiceProvider);
    final judgments = ref.read(judgmentProvider);

    state = searchService.search(
      judgments: judgments,
      query: query,
      court: court,
      category: category,
      lawReport: lawReport,
    );
  }

  void clearSearch() {
    state = ref.read(judgmentProvider);
  }
}
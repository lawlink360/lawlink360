import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/law_model.dart';
import '../services/law_service.dart';

final lawServiceProvider = Provider<LawService>((ref) {
  return const LawService();
});

final lawProvider =
    StateNotifierProvider<LawNotifier, LawState>((ref) {
  final service = ref.watch(lawServiceProvider);

  return LawNotifier(service);
});

class LawNotifier extends StateNotifier<LawState> {
  LawNotifier(this._service)
      : super(const LawState()) {
    loadLaws();
  }

  final LawService _service;

  /// Loads all laws from the law service.
  void loadLaws() {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: null,
      );

      final laws = _service.getAllLaws();

      state = state.copyWith(
        laws: laws,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Selects a law for detail viewing.
  void selectLaw(LawModel? law) {
    state = state.copyWith(
      selectedLaw: law,
    );
  }

  /// Finds a law by its ID.
  LawModel? getLawById(String lawId) {
    return _service.getLawById(lawId);
  }

  /// Gets laws belonging to a category.
  List<LawModel> getLawsByCategory(
    String categoryId,
  ) {
    return _service.getLawsByCategory(categoryId);
  }

  /// Gets laws beginning with a specific letter.
  List<LawModel> getLawsByLetter(
    String letter,
  ) {
    return _service.getLawsByLetter(letter);
  }

  /// Returns featured laws.
  List<LawModel> getFeaturedLaws({
    int limit = 5,
  }) {
    return _service.getFeaturedLaws(
      limit: limit,
    );
  }

  /// Refreshes the law library.
  void refresh() {
    loadLaws();
  }

  /// Clears the selected law.
  void clearSelectedLaw() {
    state = state.copyWith(
      selectedLaw: null,
    );
  }
}

class LawState {
  const LawState({
    this.laws = const [],
    this.selectedLaw,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<LawModel> laws;
  final LawModel? selectedLaw;
  final bool isLoading;
  final String? errorMessage;

  LawState copyWith({
    List<LawModel>? laws,
    LawModel? selectedLaw,
    bool clearSelectedLaw = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LawState(
      laws: laws ?? this.laws,
      selectedLaw: clearSelectedLaw
          ? null
          : selectedLaw ?? this.selectedLaw,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
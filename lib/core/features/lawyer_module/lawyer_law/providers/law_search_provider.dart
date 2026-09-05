import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/law_model.dart';
import '../services/law_search_service.dart';

final lawSearchServiceProvider = Provider<LawSearchService>((ref) {
  return const LawSearchService();
});

final lawSearchProvider =
    StateNotifierProvider<LawSearchNotifier, LawSearchState>((ref) {
  final service = ref.watch(lawSearchServiceProvider);

  return LawSearchNotifier(service);
});

class LawSearchNotifier extends StateNotifier<LawSearchState> {
  LawSearchNotifier(this._service)
      : super(const LawSearchState());

  final LawSearchService _service;

  /// Searches the complete law library.
  void search(String query) {
    state = state.copyWith(
      query: query,
      isSearching: true,
    );

    try {
      final results = _service.search(query);

      state = state.copyWith(
        results: results,
        suggestions: const [],
        isSearching: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Searches laws within a specific category.
  void searchByCategory({
    required String query,
    required String categoryId,
  }) {
    state = state.copyWith(
      query: query,
      categoryId: categoryId,
      isSearching: true,
    );

    try {
      final results = _service.searchByCategory(
        query: query,
        categoryId: categoryId,
      );

      state = state.copyWith(
        results: results,
        suggestions: const [],
        isSearching: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Searches laws by year.
  void searchByYear(int year) {
    state = state.copyWith(
      query: year.toString(),
      isSearching: true,
    );

    try {
      final results = _service.searchByYear(year);

      state = state.copyWith(
        results: results,
        suggestions: const [],
        isSearching: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Searches laws by starting letter.
  void searchByLetter(String letter) {
    state = state.copyWith(
      query: letter,
      isSearching: true,
    );

    try {
      final results = _service.searchByLetter(letter);

      state = state.copyWith(
        results: results,
        suggestions: const [],
        isSearching: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Generates search suggestions.
  void getSuggestions(String query) {
    if (query.trim().isEmpty) {
      state = state.copyWith(
        suggestions: const [],
      );
      return;
    }

    try {
      final suggestions = _service.getSuggestions(query);

      state = state.copyWith(
        suggestions: suggestions,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        suggestions: const [],
        errorMessage: e.toString(),
      );
    }
  }

  /// Clears search query and results.
  void clearSearch() {
    state = const LawSearchState();
  }

  /// Clears only the selected category filter.
  void clearCategoryFilter() {
    state = state.copyWith(
      categoryId: null,
    );
  }
}

class LawSearchState {
  const LawSearchState({
    this.query = '',
    this.results = const [],
    this.suggestions = const [],
    this.categoryId,
    this.isSearching = false,
    this.errorMessage,
  });

  final String query;
  final List<LawModel> results;
  final List<LawModel> suggestions;
  final String? categoryId;
  final bool isSearching;
  final String? errorMessage;

  LawSearchState copyWith({
    String? query,
    List<LawModel>? results,
    List<LawModel>? suggestions,
    String? categoryId,
    bool clearCategoryId = false,
    bool? isSearching,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LawSearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      suggestions: suggestions ?? this.suggestions,
      categoryId: clearCategoryId
          ? null
          : categoryId ?? this.categoryId,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
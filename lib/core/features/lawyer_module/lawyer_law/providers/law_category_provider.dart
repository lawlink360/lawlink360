import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/law_categories_data.dart';
import '../models/law_category_model.dart';
import '../models/law_model.dart';
import '../services/law_service.dart';
import 'law_provider.dart';

final lawCategoryProvider =
    StateNotifierProvider<LawCategoryNotifier, LawCategoryState>(
  (ref) {
    final lawService = ref.watch(lawServiceProvider);

    return LawCategoryNotifier(lawService);
  },
);

class LawCategoryNotifier
    extends StateNotifier<LawCategoryState> {
  LawCategoryNotifier(this._lawService)
      : super(const LawCategoryState()) {
    loadCategories();
  }

  final LawService _lawService;

  /// Loads all law categories.
  void loadCategories() {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: null,
      );

      final categories = List<LawCategoryModel>.from(
        LawCategoriesData.categories,
      );

      state = state.copyWith(
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Selects a category.
  void selectCategory(
    LawCategoryModel? category,
  ) {
    state = state.copyWith(
      selectedCategory: category,
    );
  }

  /// Returns laws belonging to a category.
  List<LawModel> getLawsByCategory(
    String categoryId,
  ) {
    return _lawService.getLawsByCategory(
      categoryId,
    );
  }

  /// Clears the currently selected category.
  void clearSelectedCategory() {
    state = state.copyWith(
      clearSelectedCategory: true,
    );
  }

  /// Refreshes categories.
  void refresh() {
    loadCategories();
  }
}

class LawCategoryState {
  const LawCategoryState({
    this.categories = const [],
    this.selectedCategory,
    this.isLoading = false,
    this.errorMessage,
  });

  final List<LawCategoryModel> categories;
  final LawCategoryModel? selectedCategory;
  final bool isLoading;
  final String? errorMessage;

  LawCategoryState copyWith({
    List<LawCategoryModel>? categories,
    LawCategoryModel? selectedCategory,
    bool clearSelectedCategory = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LawCategoryState(
      categories: categories ?? this.categories,
      selectedCategory: clearSelectedCategory
          ? null
          : selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }
}
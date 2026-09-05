import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_content/data/mock/admin_content_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_category_model.dart';

final adminContentCategoryProvider = NotifierProvider<
    AdminContentCategoryNotifier,
    AsyncValue<List<ContentCategoryModel>>>(
  AdminContentCategoryNotifier.new,
);

class AdminContentCategoryNotifier
    extends Notifier<AsyncValue<List<ContentCategoryModel>>> {
  final List<ContentCategoryModel> _categories = [];

  String _searchQuery = '';

  @override
  AsyncValue<List<ContentCategoryModel>> build() {
    _categories
      ..clear()
      ..addAll(AdminContentMockData.getCategories());

    return AsyncValue.data(_applyFilters());
  }

  String get searchQuery => _searchQuery;

  List<ContentCategoryModel> get categories =>
      List.unmodifiable(_categories);

  List<ContentCategoryModel> get filteredCategories =>
      _applyFilters();

  int get totalCategories => _categories.length;

  int get activeCategories =>
      _categories.where((category) => category.isActive).length;

  int get inactiveCategories =>
      _categories.where((category) => !category.isActive).length;

  List<ContentCategoryModel> _applyFilters() {
    var result = List<ContentCategoryModel>.from(_categories);

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();

      result = result.where((category) {
        return category.name.toLowerCase().contains(query) ||
            category.description.toLowerCase().contains(query);
      }).toList();
    }

    result.sort(
      (a, b) => a.sortOrder.compareTo(b.sortOrder),
    );

    return result;
  }

  void _emitFiltered() {
    state = AsyncValue.data(_applyFilters());
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    _categories
      ..clear()
      ..addAll(AdminContentMockData.getCategories());

    _emitFiltered();
  }

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void clearSearch() {
    _searchQuery = '';
    _emitFiltered();
  }

  ContentCategoryModel? getCategoryById(String id) {
    for (final category in _categories) {
      if (category.id == id) {
        return category;
      }
    }

    return null;
  }

  void toggleCategoryActive(String id) {
    final index = _categories.indexWhere(
      (category) => category.id == id,
    );

    if (index == -1) {
      return;
    }

    final current = _categories[index];

    _categories[index] = current.copyWith(
      isActive: !current.isActive,
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void updateCategory(ContentCategoryModel updatedCategory) {
    final index = _categories.indexWhere(
      (category) => category.id == updatedCategory.id,
    );

    if (index == -1) {
      return;
    }

    _categories[index] = updatedCategory.copyWith(
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void addCategory(ContentCategoryModel category) {
    _categories.add(category);
    _emitFiltered();
  }

  void deleteCategory(String id) {
    _categories.removeWhere(
      (category) => category.id == id,
    );

    _emitFiltered();
  }
}
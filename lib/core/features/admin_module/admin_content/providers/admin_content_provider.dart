import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_content/data/mock/admin_content_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/admin_content_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';

final adminContentProvider = NotifierProvider<AdminContentNotifier,
    AsyncValue<List<AdminContentModel>>>(
  AdminContentNotifier.new,
);

class AdminContentNotifier
    extends Notifier<AsyncValue<List<AdminContentModel>>> {
  final List<AdminContentModel> _contents = [];
  String _searchQuery = '';
  String _categoryFilter = 'All';
  String _statusFilter = 'All';

  @override
  AsyncValue<List<AdminContentModel>> build() {
    _contents
      ..clear()
      ..addAll(AdminContentMockData.getContents());

    return AsyncValue.data(_applyFilters());
  }

  String get searchQuery => _searchQuery;

  String get categoryFilter => _categoryFilter;

  String get statusFilter => _statusFilter;

  List<AdminContentModel> get contents => List.unmodifiable(_contents);

  List<AdminContentModel> get filteredContents => _applyFilters();

  int get totalContents => _contents.length;

  int get publishedContents => _contents
      .where((content) => content.status == ContentStatus.published)
      .length;

  int get draftContents => _contents
      .where((content) => content.status == ContentStatus.draft)
      .length;

  int get scheduledContents => _contents
      .where((content) => content.status == ContentStatus.scheduled)
      .length;

  int get archivedContents => _contents
      .where((content) => content.status == ContentStatus.archived)
      .length;

  int get featuredContents =>
      _contents.where((content) => content.isFeatured).length;

  List<String> get categories {
    final values = _contents
        .map((content) => content.category)
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList();

    values.sort();
    return ['All', ...values];
  }

  List<AdminContentModel> _applyFilters() {
    var result = List<AdminContentModel>.from(_contents);

    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();

      result = result.where((content) {
        return content.title.toLowerCase().contains(query) ||
            content.description.toLowerCase().contains(query) ||
            content.content.toLowerCase().contains(query) ||
            content.category.toLowerCase().contains(query) ||
            content.authorName.toLowerCase().contains(query);
      }).toList();
    }

    if (_categoryFilter != 'All') {
      result = result
          .where((content) => content.category == _categoryFilter)
          .toList();
    }

    if (_statusFilter != 'All') {
      result = result
          .where(
            (content) => content.status.label == _statusFilter,
          )
          .toList();
    }

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

    _contents
      ..clear()
      ..addAll(AdminContentMockData.getContents());

    _emitFiltered();
  }

  void search(String query) {
    _searchQuery = query;
    _emitFiltered();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    _emitFiltered();
  }

  void setStatusFilter(String status) {
    _statusFilter = status;
    _emitFiltered();
  }

  void clearFilters() {
    _searchQuery = '';
    _categoryFilter = 'All';
    _statusFilter = 'All';
    _emitFiltered();
  }

  AdminContentModel? getContentById(String id) {
    for (final content in _contents) {
      if (content.id == id) {
        return content;
      }
    }

    return null;
  }

  void setContentStatus(
    String id,
    ContentStatus status,
  ) {
    final index = _contents.indexWhere(
      (content) => content.id == id,
    );

    if (index == -1) {
      return;
    }

    final current = _contents[index];

    _contents[index] = current.copyWith(
      status: status,
      publishedAt: status == ContentStatus.published
          ? DateTime.now()
          : current.publishedAt,
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void publishContent(String id) {
    setContentStatus(
      id,
      ContentStatus.published,
    );
  }

  void archiveContent(String id) {
    setContentStatus(
      id,
      ContentStatus.archived,
    );
  }

  void restoreToDraft(String id) {
    setContentStatus(
      id,
      ContentStatus.draft,
    );
  }

  void scheduleContent(String id) {
    setContentStatus(
      id,
      ContentStatus.scheduled,
    );
  }

  void toggleFeatured(String id) {
    final index = _contents.indexWhere(
      (content) => content.id == id,
    );

    if (index == -1) {
      return;
    }

    final current = _contents[index];

    _contents[index] = current.copyWith(
      isFeatured: !current.isFeatured,
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void addContent(AdminContentModel content) {
    _contents.insert(0, content);
    _emitFiltered();
  }

  void updateContent(AdminContentModel updatedContent) {
    final index = _contents.indexWhere(
      (content) => content.id == updatedContent.id,
    );

    if (index == -1) {
      return;
    }

    _contents[index] = updatedContent.copyWith(
      updatedAt: DateTime.now(),
    );

    _emitFiltered();
  }

  void deleteContent(String id) {
    _contents.removeWhere(
      (content) => content.id == id,
    );

    _emitFiltered();
  }
}
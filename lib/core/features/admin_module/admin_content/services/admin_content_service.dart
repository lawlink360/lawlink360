import 'package:lawlink360/core/features/admin_module/admin_content/data/mock/admin_content_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/admin_content_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_category_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';

class AdminContentService {
  AdminContentService._();

  static final AdminContentService instance =
      AdminContentService._();

  Future<List<AdminContentModel>> getContents() async {
    await _simulateDelay();

    return AdminContentMockData.getContents();
  }

  Future<AdminContentModel?> getContentById(
    String id,
  ) async {
    await _simulateDelay();

    return AdminContentMockData.getContentById(id);
  }

  Future<List<ContentCategoryModel>> getCategories() async {
    await _simulateDelay();

    return AdminContentMockData.getCategories();
  }

  Future<ContentCategoryModel?> getCategoryById(
    String id,
  ) async {
    await _simulateDelay();

    return AdminContentMockData.getCategoryById(id);
  }

  Future<List<AdminContentModel>> getContentsByCategory(
    String category,
  ) async {
    await _simulateDelay();

    return AdminContentMockData.getContents()
        .where(
          (content) => content.category == category,
        )
        .toList();
  }

  Future<List<AdminContentModel>> getContentsByStatus(
    ContentStatus status,
  ) async {
    await _simulateDelay();

    return AdminContentMockData.getContents()
        .where(
          (content) => content.status == status,
        )
        .toList();
  }

  Future<List<AdminContentModel>> searchContents(
    String query,
  ) async {
    await _simulateDelay();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return AdminContentMockData.getContents();
    }

    return AdminContentMockData.getContents()
        .where(
          (content) =>
              content.title.toLowerCase().contains(normalizedQuery) ||
              content.description
                  .toLowerCase()
                  .contains(normalizedQuery) ||
              content.content
                  .toLowerCase()
                  .contains(normalizedQuery) ||
              content.category
                  .toLowerCase()
                  .contains(normalizedQuery) ||
              content.authorName
                  .toLowerCase()
                  .contains(normalizedQuery),
        )
        .toList();
  }

  Future<bool> createContent(
    AdminContentModel content,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> updateContent(
    AdminContentModel content,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> deleteContent(
    String id,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> updateContentStatus(
    String id,
    ContentStatus status,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> toggleFeatured(
    String id,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> createCategory(
    ContentCategoryModel category,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> updateCategory(
    ContentCategoryModel category,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> deleteCategory(
    String id,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<bool> toggleCategoryActive(
    String id,
  ) async {
    await _simulateDelay();

    return true;
  }

  Future<void> _simulateDelay() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );
  }
}
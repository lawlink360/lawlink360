import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/document_category.dart';
import '../models/document_subcategory.dart';
import '../models/document_template.dart';

class DocumentJsonService {
  static bool loaded = false;

  static List<DocumentCategory> categories = [];
  static List<DocumentSubCategory> subCategories = [];
  static List<DocumentTemplate> templates = [];

  // ============================================================
  // CATEGORY ICON / COLOR MAPS
  // ============================================================

  static const Map<String, IconData> _categoryIconById = {
    'cat_court_applications': Icons.gavel_rounded,
    'cat_government_applications': Icons.account_balance_rounded,
    'cat_legal_notices': Icons.campaign_rounded,
    'cat_contracts_agreements': Icons.handshake_rounded,
    'cat_business_documents': Icons.business_center_rounded,
    'cat_personal_professional_documents': Icons.person_rounded,
    'cat_affidavits': Icons.verified_rounded,
    'cat_government_prescribed_forms': Icons.description_rounded,
  };

  static const Map<String, Color> _categoryColorById = {
    'cat_court_applications': Color(0xFFF59E0B),
    'cat_government_applications': Color(0xFF10B981),
    'cat_legal_notices': Color(0xFFEF4444),
    'cat_contracts_agreements': Color(0xFF8B5CF6),
    'cat_business_documents': Color(0xFF0EA5E9),
    'cat_personal_professional_documents': Color(0xFF14B8A6),
    'cat_affidavits': Color(0xFFD97706),
    'cat_government_prescribed_forms': Color(0xFF2563EB),
  };

  static const IconData _defaultIcon = Icons.description_rounded;
  static const Color _defaultColor = Color(0xFF2563EB);

  // ============================================================
  // DEFAULT TEMPLATE BODY (FALLBACK)
  // ============================================================

  static const String _defaultTemplateBody = '''
This is a temporary document preview.

The complete professionally drafted document for this template will be added in the final version of LawLink360.
''';

  // ============================================================
  // ASSET PATHS
  // ============================================================

  static const String _categoriesPath =
      'assets/application_data/categories/categories.json';

  static const String _subCategoriesPath =
      'assets/application_data/subcategories/subcategories.json';

  static const String _templateMetadataFolder =
      'assets/application_data/template/';

  static const String _templateContentFolder =
      'assets/application_data/template_contents/';

  // Exact on-disk metadata filenames.
  static const List<String> _templateMetadataFiles = [
    'affidavits_templates.json',
    'business_documents_templates.json',
    'contracts_agreements_templates.json',
    'court_application_templates.json',
    'government_application_templates.json',
    'government_prescribed_forms_templates.json',
    'legal_notices_templates.json',
    'personal_professional_templates.json',
  ];

  // Exact on-disk content filenames.
  // NOTE: names below match the on-disk layout exactly, including the
  // two files that do not carry the "_content" suffix.
  static const List<String> _templateContentFiles = [
    'affidavit_templates_content.json',
    'business_documents_templates_content.json',
    'contracts_agreements_templates.json',
    'court_application_templates_content.json',
    'government_application_templates_content.json',
    'government_prescribed_forms_templates_content.json',
    'legal_notices_templates.json',
    'personal_professional_templates_content.json',
  ];

  // ============================================================
  // INIT
  // ============================================================

  static Future<void> init() async {
    if (loaded) return;

    try {
      // --------------------------------------------------------
      // CATEGORIES
      // Build into a local list; do not touch the static field yet.
      // --------------------------------------------------------

      final String categoriesRaw =
          await rootBundle.loadString(_categoriesPath);
      final List<dynamic> categoriesJson = jsonDecode(categoriesRaw);

      final List<DocumentCategory> localCategories =
          categoriesJson.map((item) {
        final String id = item['id'] ?? '';
        return DocumentCategory(
          id: id,
          title: item['name'] ?? '',
          description: item['description'] ?? '',
          icon: _categoryIconById[id] ?? _defaultIcon,
          color: _categoryColorById[id] ?? _defaultColor,
        );
      }).toList();

      // --------------------------------------------------------
      // SUBCATEGORIES
      // Build into a local list; do not touch the static field yet.
      // --------------------------------------------------------

      final String subCategoriesRaw =
          await rootBundle.loadString(_subCategoriesPath);
      final List<dynamic> subCategoriesJson =
          jsonDecode(subCategoriesRaw);

      final List<DocumentSubCategory> localSubCategories =
          subCategoriesJson.map((item) {
        final String categoryId = item['categoryId'] ?? '';
        return DocumentSubCategory(
          id: item['id'] ?? '',
          categoryId: categoryId,
          title: item['name'] ?? '',
          description: item['description'] ?? '',
          icon: _categoryIconById[categoryId] ?? _defaultIcon,
          color: _categoryColorById[categoryId] ?? _defaultColor,
          templateCount: 0,
        );
      }).toList();

      // --------------------------------------------------------
      // TEMPLATE METADATA
      // Read the 8 per-category metadata files and merge into a
      // local list. Per-file failures continue to be swallowed
      // (existing behaviour), but the overall catalogue is only
      // committed on full success.
      // --------------------------------------------------------

      final List<dynamic> mergedTemplatesJson = [];

      for (final fileName in _templateMetadataFiles) {
        try {
          final String raw = await rootBundle.loadString(
            '$_templateMetadataFolder$fileName',
          );
          final List<dynamic> parsed = jsonDecode(raw);
          mergedTemplatesJson.addAll(parsed);
        } catch (e) {
          debugPrint(
            'DocumentJsonService: failed to load metadata "$fileName": $e',
          );
        }
      }

      // --------------------------------------------------------
      // TEMPLATE CONTENT (BODY) INDEX
      // Read the 8 per-category content files and build a map
      // from templateId -> body. Content files are currently
      // empty; missing/mismatched entries fall back to the
      // default body below.
      // --------------------------------------------------------

      final Map<String, String> bodyByTemplateId = {};

      for (final fileName in _templateContentFiles) {
        try {
          final String raw = await rootBundle.loadString(
            '$_templateContentFolder$fileName',
          );
          final List<dynamic> parsed = jsonDecode(raw);

          for (final entry in parsed) {
            if (entry is! Map) continue;

            final String? key =
                (entry['templateId'] ?? entry['id']) as String?;
            if (key == null || key.isEmpty) continue;

            final String? bodyText =
                (entry['body'] ?? entry['content']) as String?;
            if (bodyText == null || bodyText.isEmpty) continue;

            bodyByTemplateId[key] = bodyText;
          }
        } catch (e) {
          debugPrint(
            'DocumentJsonService: failed to load content "$fileName": $e',
          );
        }
      }

      // --------------------------------------------------------
      // BUILD TEMPLATES
      // Build into a local list using the local subcategories
      // so parent icon/color resolution matches what will be
      // committed.
      // --------------------------------------------------------

      DocumentSubCategory? findLocalSubCategory(String id) {
        for (final s in localSubCategories) {
          if (s.id == id) return s;
        }
        return null;
      }

      final List<DocumentTemplate> localTemplates =
          mergedTemplatesJson.map((item) {
        final String subCategoryId = item['subCategoryId'] ?? '';
        final String id = item['id'] ?? '';

        final DocumentSubCategory? parentSub =
            findLocalSubCategory(subCategoryId);
        final Color color = parentSub?.color ?? _defaultColor;
        final IconData icon = parentSub?.icon ?? _defaultIcon;

        final String body =
            bodyByTemplateId[id] ?? _defaultTemplateBody;

        return DocumentTemplate(
          id: id,
          subCategoryId: subCategoryId,
          title: item['name'] ?? '',
          description: item['description'] ?? '',
          body: body,
          icon: icon,
          color: color,
        );
      }).toList();

      // --------------------------------------------------------
      // ATOMIC COMMIT
      // All required loading has succeeded. Assign the completed
      // collections and flip the loaded flag.
      // --------------------------------------------------------

      categories = localCategories;
      subCategories = localSubCategories;
      templates = localTemplates;
      loaded = true;
    } catch (e, stack) {
      debugPrint('DocumentJsonService.init failed: $e');
      debugPrint('$stack');

      // Clean failed state: never leave partially loaded data
      // visible to callers.
      categories = [];
      subCategories = [];
      templates = [];
      loaded = false;
    }
  }

  // ============================================================
  // HELPERS
  // ============================================================

  static List<DocumentCategory> getCategories() {
    return categories;
  }

  static List<DocumentSubCategory> getSubCategories(String categoryId) {
    return subCategories.where((s) => s.categoryId == categoryId).toList();
  }

  static List<DocumentTemplate> getTemplates(String subCategoryId) {
    return templates.where((t) => t.subCategoryId == subCategoryId).toList();
  }

  static DocumentCategory? getCategory(String id) {
    for (final c in categories) {
      if (c.id == id) return c;
    }
    return null;
  }
}
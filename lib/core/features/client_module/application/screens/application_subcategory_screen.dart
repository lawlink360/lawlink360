import 'package:flutter/material.dart';

import '../models/document_subcategory.dart';
import '../models/document_template.dart';

import '../services/document_data_service.dart';

import '../widgets/template/application_template_grid.dart';
import '../widgets/template/application_template_header.dart';

class ApplicationSubCategoryScreen extends StatelessWidget {
  final DocumentSubCategory subCategory;

  const ApplicationSubCategoryScreen({
    super.key,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final List<DocumentTemplate> templates =
        DocumentDataService.getTemplates(subCategory.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            ApplicationTemplateHeader(
              category: DocumentDataService.getCategory(
                subCategory.categoryId,
              )!,
              totalServices: templates.length,
            ),

            Expanded(
              child: ApplicationTemplateGrid(
                templates: templates,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
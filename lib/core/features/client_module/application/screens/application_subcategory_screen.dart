import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';

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

    final category = DocumentDataService.getCategory(
      subCategory.categoryId,
    );

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            ApplicationTemplateHeader(
              category: category!,
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

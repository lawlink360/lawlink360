import 'package:flutter/material.dart';

import '../models/document_category.dart';
import '../models/document_subcategory.dart';

import '../services/document_data_service.dart';

import '../widgets/template/application_template_header.dart';
import '../widgets/subcategory/application_subcategory_grid.dart';

class ApplicationCategoryScreen extends StatelessWidget {
  final DocumentCategory category;

  const ApplicationCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<DocumentSubCategory> subCategories =
        DocumentDataService.getSubCategories(category.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            ApplicationTemplateHeader(
              category: category,
              totalServices: subCategories.length,
            ),

            Expanded(
              child: ApplicationSubCategoryGrid(
                category: category,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
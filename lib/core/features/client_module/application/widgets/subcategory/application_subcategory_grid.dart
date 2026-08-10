import 'package:flutter/material.dart';

import '../../models/document_category.dart';
import '../../models/document_subcategory.dart';

import '../../services/document_data_service.dart';
import '../../screens/application_subcategory_screen.dart';

import 'application_subcategory_card.dart';

class ApplicationSubCategoryGrid extends StatelessWidget {
  final DocumentCategory category;

  const ApplicationSubCategoryGrid({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<DocumentSubCategory> subCategories =
        DocumentDataService.getSubCategories(category.id);

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 30),
      itemCount: subCategories.length,
      itemBuilder: (context, index) {
        final subCategory = subCategories[index];

        return ApplicationSubCategoryCard(
          subCategory: subCategory,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApplicationSubCategoryScreen(
                  subCategory: subCategory,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

import '../models/verification_category.dart';
import '../models/verification_subcategory.dart';
import '../services/verification_data_service.dart';

import '../widgets/services/category_service_header.dart';
import '../widgets/subcategory/subcategory_grid.dart';

class CategoryServicesScreen extends StatelessWidget {
  final VerificationCategory category;

  const CategoryServicesScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<VerificationSubCategory> subCategories =
        VerificationDataService.getSubCategories(category.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            CategoryServiceHeader(
              category: category,
              totalServices: subCategories.length,
            ),

            Expanded(
              child: SubCategoryGrid(
                subCategories: subCategories,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
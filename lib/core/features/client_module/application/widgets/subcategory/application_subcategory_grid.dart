import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_category.dart';
import '../../models/document_subcategory.dart';
import '../../screens/application_subcategory_screen.dart';
import '../../services/document_data_service.dart';
import '../../services/document_json_service.dart';
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
        DocumentJsonService.loaded
            ? DocumentJsonService.getSubCategories(category.id)
            : DocumentDataService.getSubCategories(category.id);

    if (subCategories.isEmpty) {
      return const _EmptySubCategoryState();
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.xl,
      ),
      itemCount: subCategories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.0,
      ),
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

class _EmptySubCategoryState extends StatelessWidget {
  const _EmptySubCategoryState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.dashboard_customize_rounded,
              color: colorScheme.onSurface.withValues(alpha: 0.55),
              size: 32,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'No subcategories available',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
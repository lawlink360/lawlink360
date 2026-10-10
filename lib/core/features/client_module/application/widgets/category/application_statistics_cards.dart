import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_category.dart';
import '../../models/document_subcategory.dart';
import '../../models/document_template.dart';
import '../../services/document_data_service.dart';
import '../../services/document_json_service.dart';

class ApplicationStatisticsCards extends StatelessWidget {
  const ApplicationStatisticsCards({super.key});

  List<DocumentCategory> get _categories =>
      DocumentJsonService.loaded
          ? DocumentJsonService.getCategories()
          : DocumentDataService.categories;

  List<DocumentSubCategory> _subCategoriesOf(String categoryId) =>
      DocumentJsonService.loaded
          ? DocumentJsonService.getSubCategories(categoryId)
          : DocumentDataService.getSubCategories(categoryId);

  List<DocumentTemplate> _templatesOf(String subCategoryId) =>
      DocumentJsonService.loaded
          ? DocumentJsonService.getTemplates(subCategoryId)
          : DocumentDataService.getTemplates(subCategoryId);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final categories = _categories;

    int totalSubCategories = 0;
    int totalTemplates = 0;

    for (final category in categories) {
      final subCategories = _subCategoriesOf(category.id);
      totalSubCategories += subCategories.length;

      for (final subCategory in subCategories) {
        totalTemplates += _templatesOf(subCategory.id).length;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            StatisticCard(
              title: 'Templates',
              value: '$totalTemplates',
              icon: Icons.description_rounded,
              color: colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            StatisticCard(
              title: 'Subcategories',
              value: '$totalSubCategories',
              icon: Icons.dashboard_customize_rounded,
              color: colorScheme.secondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            StatisticCard(
              title: 'Categories',
              value: '${categories.length}',
              icon: Icons.dashboard_customize_rounded,
              color: AppColors.warning,
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 96,
      height: 108,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.11),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.16),
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 18,
              ),
            ),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
                fontSize: 20,
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.58),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
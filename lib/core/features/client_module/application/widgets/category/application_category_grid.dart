import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_category.dart';
import '../../screens/application_category_screen.dart';
import '../../services/document_data_service.dart';
import 'application_category_card.dart';

class ApplicationCategoryGrid extends StatelessWidget {
  const ApplicationCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<DocumentCategory> categories =
        DocumentDataService.categories;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse by Category',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.76,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];

              return ApplicationCategoryCard(
                title: category.title,
                description: category.description,
                icon: category.icon,
                color: category.color,
                templateCount: DocumentDataService
                    .getSubCategories(category.id)
                    .length,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ApplicationCategoryScreen(
                        category: category,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: AppSpacing.xs),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.035),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 17,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Choose a category to explore available document templates.',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.62),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

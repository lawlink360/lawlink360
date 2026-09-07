import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'category_card.dart';

import '../../models/verification_category.dart';
import '../../screens/category_services_screen.dart';
import '../../services/verification_data_service.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<VerificationCategory> categories =
        VerificationDataService.categories;

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
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryCard(
                title: category.title,
                description: category.description,
                icon: category.icon,
                color: category.color,
                serviceCount: VerificationDataService.getSubCategories(
                  category.id,
                ).length,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CategoryServicesScreen(category: category),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_subcategory.dart';

class ApplicationSubCategoryCard extends StatelessWidget {
  final DocumentSubCategory subCategory;
  final VoidCallback? onTap;

  const ApplicationSubCategoryCard({
    super.key,
    required this.subCategory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: subCategory.color.withValues(alpha: 0.11),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: subCategory.color.withValues(alpha: 0.16),
                  ),
                ),
                child: Icon(
                  subCategory.icon,
                  color: subCategory.color,
                  size: 26,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                subCategory.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
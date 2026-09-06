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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Ink(
            padding: const EdgeInsets.all(AppSpacing.md),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
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
                    size: 24,
                  ),
                ),

                const SizedBox(width: AppSpacing.sm),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subCategory.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        subCategory.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.62),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppSpacing.sm),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${subCategory.templateCount}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: subCategory.color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Templates',
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.52),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: AppSpacing.sm),

                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.42),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

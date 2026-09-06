import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_category.dart';

class ApplicationTemplateHeader extends StatelessWidget {
  final DocumentCategory category;
  final int totalServices;

  const ApplicationTemplateHeader({
    super.key,
    required this.category,
    required this.totalServices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.xl),
          bottomRight: Radius.circular(AppRadius.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.xs),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.textLight,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.textLight.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.textLight,
                    size: 29,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headline.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '$totalServices Sections',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textLight.withValues(alpha: 0.78),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

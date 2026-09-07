import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class RelatedLawsCard extends StatelessWidget {
  final List<String> laws;

  const RelatedLawsCard({
    super.key,
    required this.laws,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Applicable Laws',
            style: AppTextStyles.title.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ...laws.map(
            (law) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.sm,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Icons.gavel,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      law,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
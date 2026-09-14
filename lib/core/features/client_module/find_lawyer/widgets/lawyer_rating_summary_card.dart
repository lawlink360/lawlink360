import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerRatingSummaryCard extends StatelessWidget {
  const LawyerRatingSummaryCard({super.key});

  Widget ratingBar(
    BuildContext context,
    int stars,
    double value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            '$stars',
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Icon(
          Icons.star_rounded,
          size: 17,
          color: AppColors.accent,
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: colorScheme.outline.withValues(
                alpha: 0.18,
              ),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.accent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.20 : 0.06,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.accent,
                  size: 23,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Client Ratings',
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '4.9',
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.accent,
              fontSize: 48,
              height: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 21,
              ),
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 21,
              ),
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 21,
              ),
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 21,
              ),
              Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 21,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Based on 428 verified client reviews',
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ratingBar(context, 5, 0.94),
          const SizedBox(height: AppSpacing.sm),
          ratingBar(context, 4, 0.75),
          const SizedBox(height: AppSpacing.sm),
          ratingBar(context, 3, 0.20),
          const SizedBox(height: AppSpacing.sm),
          ratingBar(context, 2, 0.08),
          const SizedBox(height: AppSpacing.sm),
          ratingBar(context, 1, 0.03),
        ],
      ),
    );
  }
}
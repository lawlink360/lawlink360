import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerRatingSummaryCard extends StatelessWidget {
  final Lawyer? lawyer;

  const LawyerRatingSummaryCard({
    super.key,
    this.lawyer,
  });

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
            borderRadius: BorderRadius.circular(
              AppRadius.pill,
            ),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor:
                  colorScheme.outline.withValues(
                alpha: 0.18,
              ),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(
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
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final rating =
        lawyer?.rating.toStringAsFixed(1) ?? '4.9';

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppRadius.xl,
        ),
        border: Border.all(
          color: colorScheme.outline.withValues(
            alpha: 0.45,
          ),
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
                  color: AppColors.accent.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
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
                  'Client Ratings & Reviews',
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
            rating,
            style: AppTextStyles.displayLarge.copyWith(
              color: AppColors.accent,
              fontSize: 48,
              height: 1,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star_rounded,
                color: AppColors.accent,
                size: 21,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Based on 428 verified client reviews',
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.md),

          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              AppRadius.md,
            ),
            child: InkWell(
              onTap: () {
                _showReviewSummary(context);
              },
              borderRadius: BorderRadius.circular(
                AppRadius.md,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(
                    alpha: 0.07,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                  border: Border.all(
                    color: AppColors.accent.withValues(
                      alpha: 0.25,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.rate_review_outlined,
                      color: AppColors.accent,
                      size: 19,
                    ),
                    const SizedBox(
                      width: AppSpacing.xs,
                    ),
                    Text(
                      'View all reviews',
                      style:
                          AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: AppSpacing.xs,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.accent,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ),
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

  void _showReviewSummary(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.rate_review_rounded,
                  color: AppColors.accent,
                  size: 32,
                ),
                const SizedBox(
                  height: AppSpacing.sm,
                ),
                Text(
                  'Client Reviews',
                  style: AppTextStyles.title.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.sm,
                ),
                Text(
                  '428 verified clients have reviewed this lawyer.',
                  textAlign: TextAlign.center,
                  style:
                      AppTextStyles.bodySmall.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
                const SizedBox(
                  height: AppSpacing.lg,
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check_rounded,
                  ),
                  label: const Text('Done'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

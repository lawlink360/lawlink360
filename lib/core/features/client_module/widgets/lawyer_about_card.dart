import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerAboutCard extends StatelessWidget {
  const LawyerAboutCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Icons.person_outline_rounded,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'About Lawyer',
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Adv. Ahmed Khan is a highly experienced Criminal and Civil Lawyer with over 12 years of professional practice. He has successfully represented hundreds of clients before District Courts, High Courts and Special Tribunals. His approach focuses on professionalism, transparency and achieving practical legal solutions for clients.',
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}
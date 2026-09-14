import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerPracticeChip extends StatelessWidget {
  final Lawyer? lawyer;

  const LawyerPracticeChip({
    super.key,
    this.lawyer,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final practiceAreas = lawyer == null
        ? const [
            'Criminal Law',
            'Bail Matters',
            'FIR & Quash',
            'Cyber Crime',
            'White Collar',
            'Appeals',
            'Constitutional',
            'Family Law',
          ]
        : _practiceAreasFor(lawyer!.speciality);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.5),
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
          Text(
            'Practice Areas',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: practiceAreas
                .map(
                  (area) => _Chip(area),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  static List<String> _practiceAreasFor(String speciality) {
    final value = speciality.trim();

    if (value.isEmpty) {
      return const ['Legal Practice'];
    }

    return [
      value,
    ];
  }
}

class _Chip extends StatelessWidget {
  final String title;

  const _Chip(this.title);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Chip(
      avatar: const Icon(
        Icons.gavel_rounded,
        size: 18,
        color: AppColors.accent,
      ),
      label: Text(
        title,
        style: AppTextStyles.caption.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: AppColors.accent.withValues(alpha: 0.08),
      side: BorderSide(
        color: AppColors.accent.withValues(alpha: 0.55),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2,
      ),
    );
  }
}
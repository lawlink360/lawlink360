import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/procedure_data.dart';

class ProcedureStatisticsCards extends StatelessWidget {
  const ProcedureStatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final totalProcedures = ProcedureData.procedures.length;
    final totalCategories = ProcedureData.categories.length;

    int categoriesWithProcedures = 0;
    for (final category in ProcedureData.categories) {
      final hasProcedures = ProcedureData.procedures
          .any((procedure) => procedure.categoryId == category.id);
      if (hasProcedures) {
        categoriesWithProcedures++;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _StatisticCard(
              title: 'Procedures',
              value: '$totalProcedures',
              icon: Icons.description_rounded,
              color: AppColors.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatisticCard(
              title: 'Categories',
              value: '$totalCategories',
              icon: Icons.dashboard_customize_rounded,
              color: AppColors.secondary,
            ),
            const SizedBox(width: AppSpacing.sm),
            _StatisticCard(
              title: 'With Procedures',
              value: '$categoriesWithProcedures',
              icon: Icons.check_circle_outline_rounded,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 118,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.11),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.16),
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 19,
              ),
            ),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.title.copyWith(
                color: AppColors.textPrimary,
                fontSize: 22,
              ),
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
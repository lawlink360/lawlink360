import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class ApplicationStatisticsCards extends StatelessWidget {
  const ApplicationStatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: const [
            StatisticCard(
              title: 'Templates',
              value: '500+',
              icon: Icons.description_rounded,
              color: Color(0xFF2563EB),
            ),
            SizedBox(width: AppSpacing.sm),
            StatisticCard(
              title: 'Categories',
              value: '9',
              icon: Icons.dashboard_customize_rounded,
              color: AppColors.warning,
            ),
            SizedBox(width: AppSpacing.sm),
            StatisticCard(
              title: 'AI Docs',
              value: '∞',
              icon: Icons.auto_awesome_rounded,
              color: AppColors.success,
            ),
            SizedBox(width: AppSpacing.sm),
            StatisticCard(
              title: 'Saved',
              value: '0',
              icon: Icons.bookmark_rounded,
              color: Color(0xFF8B5CF6),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 96,
      height: 108,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 34,
              height: 34,
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
                size: 18,
              ),
            ),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
                fontSize: 20,
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.58),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

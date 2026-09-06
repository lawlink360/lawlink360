import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerProfileHeader extends StatelessWidget {
  const LawyerProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
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
              alpha: isDark ? 0.22 : 0.07,
            ),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accent.withValues(
                alpha: isDark ? 0.18 : 0.10,
              ),
              border: Border.all(
                color: AppColors.accent,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(
                    alpha: 0.18,
                  ),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 55,
              color: AppColors.accent,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            'Adv. Ahmed Khan',
            textAlign: TextAlign.center,
            style: AppTextStyles.headline.copyWith(
              color: colorScheme.onSurface,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            'Criminal & Civil Lawyer',
            textAlign: TextAlign.center,
            style: AppTextStyles.body.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(
                alpha: 0.10,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.pill,
              ),
              border: Border.all(
                color: AppColors.accent.withValues(
                  alpha: 0.35,
                ),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: AppColors.accent,
                  size: 18,
                ),
                SizedBox(width: AppSpacing.xs),
                Text(
                  'Verified Lawyer',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Divider(
            color: colorScheme.outline.withValues(
              alpha: 0.45,
            ),
            height: 1,
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              const Expanded(
                child: _StatItem(
                  value: '4.9',
                  label: 'Rating',
                  icon: Icons.star_rounded,
                ),
              ),
              _VerticalDivider(
                color: colorScheme.outline.withValues(
                  alpha: 0.45,
                ),
              ),
              const Expanded(
                child: _StatItem(
                  value: '12+',
                  label: 'Years',
                  icon: Icons.workspace_premium_rounded,
                ),
              ),
              _VerticalDivider(
                color: colorScheme.outline.withValues(
                  alpha: 0.45,
                ),
              ),
              const Expanded(
                child: _StatItem(
                  value: '560+',
                  label: 'Cases',
                  icon: Icons.gavel_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final Color color;

  const _VerticalDivider({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 46,
      color: color,
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.accent,
          size: 19,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
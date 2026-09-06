import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.35,
        children: [
          _Item(
            icon: Icons.workspace_premium_rounded,
            value: '10+',
            title: 'Years Experience',
            colorScheme: colorScheme,
            isDark: isDark,
          ),
          _Item(
            icon: Icons.gavel_rounded,
            value: '1,250+',
            title: 'Cases Handled',
            colorScheme: colorScheme,
            isDark: isDark,
          ),
          _Item(
            icon: Icons.people_alt_outlined,
            value: '980+',
            title: 'Happy Clients',
            colorScheme: colorScheme,
            isDark: isDark,
          ),
          _Item(
            icon: Icons.emoji_events_outlined,
            value: '95%',
            title: 'Success Rate',
            colorScheme: colorScheme,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;
  final ColorScheme colorScheme;
  final bool isDark;

  const _Item({
    required this.icon,
    required this.value,
    required this.title,
    required this.colorScheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.20 : 0.06,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.accent,
            size: 30,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.headline.copyWith(
              color: colorScheme.onSurface,
              fontSize: 23,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
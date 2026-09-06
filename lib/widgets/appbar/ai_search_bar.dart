import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AISearchBar extends StatelessWidget {
  const AISearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final secondaryTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final chipColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.18 : 0.08,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.accent,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Ask LawLink AI...',
                  style: AppTextStyles.body.copyWith(
                    color: secondaryTextColor,
                  ),
                ),
              ),
              Icon(
                Icons.search,
                color: secondaryTextColor,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _SuggestionChip(
                text: 'Bail Application',
                backgroundColor: chipColor,
                textColor: secondaryTextColor,
              ),
              _SuggestionChip(
                text: 'Property Case',
                backgroundColor: chipColor,
                textColor: secondaryTextColor,
              ),
              _SuggestionChip(
                text: 'Family Dispute',
                backgroundColor: chipColor,
                textColor: secondaryTextColor,
              ),
              _SuggestionChip(
                text: 'Lost CNIC',
                backgroundColor: chipColor,
                textColor: secondaryTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _SuggestionChip({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
        ),
      ),
      backgroundColor: backgroundColor,
      side: BorderSide.none,
    );
  }
}
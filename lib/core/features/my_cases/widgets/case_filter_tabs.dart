import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class CaseFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const CaseFilterTabs({
    super.key,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = [
      'All',
      'Active',
      'Pending',
      'Completed',
      'Archived',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;

          return ChoiceChip(
            label: Text(tabs[index]),
            selected: selected,
            onSelected: (_) => onChanged?.call(index),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.lightSurface,
            side: BorderSide(
              color: selected
                  ? AppColors.primary
                  : AppColors.lightBorder,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            labelStyle: AppTextStyles.bodySmall.copyWith(
              color: selected
                  ? Colors.white
                  : AppColors.lightTextPrimary,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class DocumentFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const DocumentFilterTabs({
    super.key,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = [
      'All',
      'Legal',
      'Applications',
      'Scanned',
      'Favorites',
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: tabs.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;

          return ChoiceChip(
            label: Text(tabs[index]),
            selected: selected,
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surface,
            side: BorderSide(
              color: selected
                  ? AppColors.primary
                  : AppColors.border,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            labelStyle: AppTextStyles.bodySmall.copyWith(
              color: selected
                  ? AppColors.textLight
                  : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
            ),
            onSelected: (_) => onChanged?.call(index),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class AppointmentFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const AppointmentFilterTabs({
    super.key,
    required this.selectedIndex,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const tabs = [
      'All',
      'Today',
      'Upcoming',
      'Completed',
      'Cancelled',
    ];

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 1),
        itemCount: tabs.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final selected = selectedIndex == index;

          return ChoiceChip(
            label: Text(tabs[index]),
            selected: selected,
            onSelected: (_) => onChanged?.call(index),
            showCheckmark: false,
            side: BorderSide(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant.withValues(alpha: 0.7),
            ),
            backgroundColor: colorScheme.surface,
            selectedColor: colorScheme.primary,
            labelStyle: AppTextStyles.bodySmall.copyWith(
              color: selected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurface.withValues(alpha: 0.78),
              fontWeight: FontWeight.w700,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            elevation: 0,
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookDateCard extends StatelessWidget {
  const BookDateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              DateCard(
                day: 'Mon',
                date: '21',
                selected: true,
              ),
              SizedBox(width: AppSpacing.sm),
              DateCard(
                day: 'Tue',
                date: '22',
              ),
              SizedBox(width: AppSpacing.sm),
              DateCard(
                day: 'Wed',
                date: '23',
              ),
              SizedBox(width: AppSpacing.sm),
              DateCard(
                day: 'Thu',
                date: '24',
              ),
              SizedBox(width: AppSpacing.sm),
              DateCard(
                day: 'Fri',
                date: '25',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DateCard extends StatelessWidget {
  final String day;
  final String date;
  final bool selected;

  const DateCard({
    super.key,
    required this.day,
    required this.date,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = selected
        ? AppColors.accent
        : colorScheme.surface;

    final borderColor = selected
        ? AppColors.accent
        : colorScheme.outline.withValues(alpha: 0.35);

    final dayColor = selected
        ? Colors.white
        : colorScheme.onSurfaceVariant;

    final dateColor = selected
        ? Colors.white
        : colorScheme.onSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 70,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: borderColor,
          width: selected ? 1.3 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.16),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: AppTextStyles.caption.copyWith(
              color: dayColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            date,
            style: AppTextStyles.title.copyWith(
              color: dateColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
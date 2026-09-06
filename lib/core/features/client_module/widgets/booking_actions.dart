import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookingActions extends StatelessWidget {
  const BookingActions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppSpacing.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.download_outlined,
                color: AppColors.accent,
                size: 20,
              ),
              label: Text(
                'Receipt',
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                side: const BorderSide(
                  color: AppColors.accent,
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: SizedBox(
            height: AppSpacing.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.event_outlined,
                color: AppColors.accent,
                size: 20,
              ),
              label: Text(
                'Calendar',
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                side: const BorderSide(
                  color: AppColors.accent,
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class EmptyAppointmentsWidget extends StatelessWidget {
  const EmptyAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.10),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.20),
                ),
              ),
              child: Icon(
                Icons.event_busy_outlined,
                size: 50,
                color: AppColors.accent,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            Text(
              'No Appointments Found',
              textAlign: TextAlign.center,
              style: AppTextStyles.headline.copyWith(
                color: colorScheme.onSurface,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 320,
              ),
              child: Text(
                'Your hearings, consultations and meetings will appear here.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.62),
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Appointments will appear here',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerBookingButton extends StatelessWidget {
  const LawyerBookingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline.withValues(
                alpha: 0.30,
              ),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: isDark ? 0.22 : 0.08,
              ),
              blurRadius: 18,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          height: AppSpacing.buttonHeight,
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Booking Screen Navigation
            },
            icon: const Icon(
              Icons.calendar_month_rounded,
              size: 21,
            ),
            label: Text(
              'Book Appointment',
              style: AppTextStyles.button.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
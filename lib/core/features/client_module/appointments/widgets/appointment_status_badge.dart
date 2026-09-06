import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/appointment_status.dart';

class AppointmentStatusBadge extends StatelessWidget {
  final AppointmentStatus status;

  const AppointmentStatusBadge({
    super.key,
    required this.status,
  });

  Color get backgroundColor {
    switch (status) {
      case AppointmentStatus.today:
        return AppColors.error.withValues(alpha: 0.12);
      case AppointmentStatus.upcoming:
        return AppColors.success.withValues(alpha: 0.12);
      case AppointmentStatus.completed:
        return AppColors.info.withValues(alpha: 0.12);
      case AppointmentStatus.cancelled:
        return AppColors.lightTextSecondary.withValues(alpha: 0.14);
    }
  }

  Color get textColor {
    switch (status) {
      case AppointmentStatus.today:
        return AppColors.error;
      case AppointmentStatus.upcoming:
        return AppColors.success;
      case AppointmentStatus.completed:
        return AppColors.info;
      case AppointmentStatus.cancelled:
        return AppColors.lightTextSecondary;
    }
  }

  String get label {
    switch (status) {
      case AppointmentStatus.today:
        return 'Today';
      case AppointmentStatus.upcoming:
        return 'Upcoming';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: textColor.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
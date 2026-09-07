import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/case_status.dart';

class CaseStatusBadge extends StatelessWidget {
  final CaseStatus status;

  const CaseStatusBadge({
    super.key,
    required this.status,
  });

  Color get backgroundColor {
    switch (status) {
      case CaseStatus.active:
        return AppColors.success.withValues(alpha: 0.12);

      case CaseStatus.pending:
        return AppColors.warning.withValues(alpha: 0.14);

      case CaseStatus.completed:
        return AppColors.info.withValues(alpha: 0.12);

      case CaseStatus.archived:
        return AppColors.lightTextSecondary.withValues(alpha: 0.12);
    }
  }

  Color get textColor {
    switch (status) {
      case CaseStatus.active:
        return AppColors.success;

      case CaseStatus.pending:
        return AppColors.warning;

      case CaseStatus.completed:
        return AppColors.info;

      case CaseStatus.archived:
        return AppColors.lightTextSecondary;
    }
  }

  String get label {
    switch (status) {
      case CaseStatus.active:
        return 'Active';

      case CaseStatus.pending:
        return 'Pending';

      case CaseStatus.completed:
        return 'Completed';

      case CaseStatus.archived:
        return 'Archived';
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
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
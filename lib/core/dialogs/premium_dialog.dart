import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../models/dialog_type.dart';

class PremiumDialog extends StatelessWidget {
  final DialogType type;
  final String title;
  final String message;

  const PremiumDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
  });
  IconData get _icon {
    switch (type) {
      case DialogType.success:
        return Icons.check_rounded;
      case DialogType.error:
        return Icons.close_rounded;
      case DialogType.warning:
        return Icons.warning_amber_rounded;
      case DialogType.info:
        return Icons.info_outline_rounded;
      case DialogType.loading:
        return Icons.hourglass_top_rounded;
    }
  }

  Color get _statusColor {
    switch (type) {
      case DialogType.success:
        return AppColors.success;
      case DialogType.error:
        return AppColors.error;
      case DialogType.warning:
        return AppColors.warning;
      case DialogType.info:
        return AppColors.info;
      case DialogType.loading:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final titleColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final messageColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: surfaceColor.withValues(alpha: isDark ? 0.94 : 0.97),
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.65),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: _statusColor.withValues(alpha: 0.14),
                  child: Icon(_icon, size: 42, color: _statusColor),
                ),

                const SizedBox(height: AppSpacing.md),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title.copyWith(color: titleColor),
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: messageColor,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: AppTextStyles.button.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

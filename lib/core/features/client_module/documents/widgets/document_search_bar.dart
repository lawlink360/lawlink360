import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class DocumentSearchBar extends StatelessWidget {
  const DocumentSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles.body.copyWith(
        color: AppColors.textPrimary,
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: 'Search documents...',
        hintStyle: AppTextStyles.body.copyWith(
          color: AppColors.textSecondary,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(
            color: AppColors.accent,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
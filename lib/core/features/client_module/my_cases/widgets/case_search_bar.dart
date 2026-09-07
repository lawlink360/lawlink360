import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class CaseSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const CaseSearchBar({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppTextStyles.body.copyWith(
        color: AppColors.lightTextPrimary,
      ),
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: 'Search by case number, lawyer or court...',
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.lightTextSecondary,
        ),
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(
            color: AppColors.lightBorder,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: const BorderSide(
            color: AppColors.accent,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
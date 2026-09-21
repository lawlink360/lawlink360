import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_page.dart';

/// Single page thumbnail used by the multi-page grid.
class ScannerMultipageThumbnail extends StatelessWidget {
  const ScannerMultipageThumbnail({
    super.key,
    required this.page,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  final ScannerPage page;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: isActive
                      ? AppColors.accent
                      : AppColors.lightBorder,
                  width: isActive ? 2 : 1,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.file(
                File(page.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.lightTextSecondary,
                    size: AppSpacing.iconMd,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.xs,
            left: AppSpacing.xs,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.accent
                    : AppColors.glassDark,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                '${index + 1}',
                style: AppTextStyles.caption.copyWith(
                  color: isActive
                      ? AppColors.primary
                      : AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_page.dart';

/// Card representing one scanned page in the document viewer.
class ScannerViewerPageCard extends StatelessWidget {
  const ScannerViewerPageCard({
    super.key,
    required this.page,
    required this.pageNumber,
    required this.onTap,
  });

  final ScannerPage page;
  final int pageNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    debugPrint('SCANNER PAGE PATH: ${page.imagePath}');
    debugPrint(
      'SCANNER PAGE FILE EXISTS: ${File(page.imagePath).existsSync()}',
    );

    return Material(
      color: AppColors.lightSurface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.lightBorder),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.file(
                    File(page.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.lightBackground,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.lightTextSecondary,
                        size: AppSpacing.iconLg,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Text(
                      'Page $pageNumber',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightTextPrimary,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.lightTextSecondary,
                      size: AppSpacing.iconSm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
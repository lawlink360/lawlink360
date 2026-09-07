import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class EmptyDocumentsWidget extends StatelessWidget {
  const EmptyDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: const Icon(
                Icons.folder_open,
                size: 52,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No Documents Found',
              textAlign: TextAlign.center,
              style: AppTextStyles.title.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Scanned, translated and generated documents will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
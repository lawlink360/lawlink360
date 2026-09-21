import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../providers/scanner_pages_provider.dart';

/// Small pill showing the number of pages in the current session.
///
/// Hidden when the count is zero.
class ScannerCameraPageCounter extends ConsumerWidget {
  const ScannerCameraPageCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(scannerPagesProvider).pages.length;

    if (count == 0) {
      return const SizedBox(width: AppSpacing.xxl);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassWhite,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        count == 1 ? '1 page' : '$count pages',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
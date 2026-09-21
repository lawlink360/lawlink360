import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// Full-area loading overlay with a centered animated indicator.
///
/// This widget is meant to be used as the top layer of a [Stack].
/// It does not present a dialog and does not block the widget tree
/// beneath it in any persistent way — the parent decides when to
/// include or remove it from the stack.
class ScannerLoadingOverlay extends StatelessWidget {
  const ScannerLoadingOverlay({
    super.key,
    this.label,
  });

  /// Optional caption shown below the indicator.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AbsorbPointer(
        child: Container(
          color: AppColors.overlayDark,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.threeRotatingDots(
                color: AppColors.textLight,
                size: AppSpacing.iconLg,
              ),
              if (label != null && label!.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
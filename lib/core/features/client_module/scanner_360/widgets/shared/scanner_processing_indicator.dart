import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// Inline row with a compact spinner and a text label.
///
/// Used for short-lived processing messages such as
/// "Detecting document…", "Processing image…", "Creating PDF…".
class ScannerProcessingIndicator extends StatelessWidget {
  const ScannerProcessingIndicator({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: AppSpacing.iconSm,
          height: AppSpacing.iconSm,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';

/// Top header for the Scanner 360 home screen.
class ScannerHomeHeader extends StatelessWidget {
  const ScannerHomeHeader({
    super.key,
    required this.onOpenSettings,
  });

  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Scanner 360',
                style: AppTextStyles.headline,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Scan, enhance and manage legal documents.',
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onOpenSettings,
          icon: const Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
            size: AppSpacing.iconMd,
          ),
          tooltip: 'Scanner settings',
        ),
      ],
    );
  }
}
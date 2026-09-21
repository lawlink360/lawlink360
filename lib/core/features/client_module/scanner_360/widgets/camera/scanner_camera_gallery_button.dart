import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';

/// Gallery import button.
class ScannerCameraGalleryButton extends StatelessWidget {
  const ScannerCameraGalleryButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.photo_library_outlined,
        color: AppColors.textLight,
        size: AppSpacing.iconMd,
      ),
      tooltip: 'Import from gallery',
    );
  }
}
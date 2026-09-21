import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import 'scanner_camera_flash_button.dart';
import 'scanner_camera_mode_toggle.dart';

/// Top row of the camera screen.
///
/// Layout: close button + flash button on the first row, mode
/// toggle on a second row directly beneath it.
class ScannerCameraTopBar extends ConsumerWidget {
  const ScannerCameraTopBar({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onClose,
              icon: const Icon(
                Icons.close,
                color: AppColors.textLight,
                size: AppSpacing.iconMd,
              ),
              tooltip: 'Close',
            ),
            const Spacer(),
            const ScannerCameraFlashButton(),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const Center(child: ScannerCameraModeToggle()),
      ],
    );
  }
}
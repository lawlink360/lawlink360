import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../providers/scanner_camera_provider.dart';

/// Flash toggle for the camera screen.
///
/// Reads the runtime [FlashMode] from [scannerCameraProvider].
/// It does not read [ScannerFlashMode] from [ScanSettings].
class ScannerCameraFlashButton extends ConsumerWidget {
  const ScannerCameraFlashButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashMode = ref.watch(scannerCameraProvider).flashMode;

    return IconButton(
      onPressed: () =>
          ref.read(scannerCameraProvider.notifier).cycleFlash(),
      icon: Icon(
        _iconFor(flashMode),
        color: AppColors.textLight,
        size: AppSpacing.iconMd,
      ),
      tooltip: 'Flash',
    );
  }

  static IconData _iconFor(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.flashlight_on;
    }
  }
}
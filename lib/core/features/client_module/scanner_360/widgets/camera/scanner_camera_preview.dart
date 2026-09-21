import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../providers/scanner_camera_provider.dart';
import '../shared/scanner_error_view.dart';

/// Renders the live camera preview from the controller exposed
/// through [scannerCameraProvider].
class ScannerCameraPreview extends ConsumerWidget {
  const ScannerCameraPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerCameraProvider);
    final controller = ref.read(scannerCameraProvider.notifier).controller;

    if (state.error != null) {
      return ScannerErrorView(
        title: 'Camera error',
        message: state.error!,
      );
    }

    if (!state.isInitialized || controller == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.textLight,
          ),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.previewSize?.height ?? 1,
          height: controller.value.previewSize?.width ?? 1,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}
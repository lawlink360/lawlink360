import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../providers/scanner_camera_provider.dart';
import '../../providers/scanner_pages_provider.dart';
import 'scanner_camera_capture_button.dart';
import 'scanner_camera_gallery_button.dart';

/// Bottom row of the camera screen.
///
/// Layout: Gallery | Capture | Pages (with page count badge).
class ScannerCameraBottomBar extends ConsumerWidget {
  const ScannerCameraBottomBar({
    super.key,
    required this.onCapture,
    required this.onOpenGallery,
    required this.onOpenPages,
  });

  final VoidCallback onCapture;
  final VoidCallback onOpenGallery;
  final VoidCallback onOpenPages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCapturing =
        ref.watch(scannerCameraProvider).isCapturing;
    final pageCount = ref.watch(scannerPagesProvider).pages.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScannerCameraGalleryButton(
          onPressed: isCapturing ? null : onOpenGallery,
        ),
        ScannerCameraCaptureButton(
          isCapturing: isCapturing,
          onPressed: isCapturing ? null : onCapture,
        ),
        _PagesButton(
          pageCount: pageCount,
          onPressed: isCapturing ? null : onOpenPages,
        ),
      ],
    );
  }
}

class _PagesButton extends StatelessWidget {
  const _PagesButton({
    required this.pageCount,
    required this.onPressed,
  });

  final int pageCount;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.collections_bookmark_outlined,
            color: AppColors.textLight,
            size: AppSpacing.iconMd,
          ),
          tooltip: 'Pages',
        ),
        if (pageCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              constraints: const BoxConstraints(minWidth: 18),
              child: Text(
                '$pageCount',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
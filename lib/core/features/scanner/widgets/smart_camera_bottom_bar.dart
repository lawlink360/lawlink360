import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'smart_capture_button.dart';

class SmartCameraBottomBar extends StatelessWidget {
  final VoidCallback? onCapture;

  const SmartCameraBottomBar({
    super.key,
    this.onCapture,
  });

  Future<void> _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Image Selected:\n${image.name}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CameraActionButton(
                icon: Icons.photo_library_outlined,
                tooltip: 'Gallery',
                onPressed: () => _openGallery(context),
              ),
              SmartCaptureButton(
                onPressed: onCapture,
              ),
              PopupMenuButton<String>(
                tooltip: 'Flash mode',
                icon: const Icon(
                  Icons.flash_auto,
                  color: AppColors.textLight,
                  size: 30,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Flash Mode: $value',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  );
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'Auto',
                    child: Text('Auto'),
                  ),
                  PopupMenuItem(
                    value: 'On',
                    child: Text('On'),
                  ),
                  PopupMenuItem(
                    value: 'Off',
                    child: Text('Off'),
                  ),
                  PopupMenuItem(
                    value: 'Torch',
                    child: Text('Torch'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _CameraActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.glassDark,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Tooltip(
            message: tooltip,
            child: Icon(
              icon,
              color: AppColors.textLight,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
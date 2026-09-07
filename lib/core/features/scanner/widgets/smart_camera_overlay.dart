import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'smart_camera_preview.dart';

class SmartCameraOverlay extends StatelessWidget {
  final CameraController controller;

  const SmartCameraOverlay({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return IgnorePointer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: AppSpacing.xs,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.glassDark,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                'Place document inside frame',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.xl,
            child: SizedBox(
              width: screenWidth * 0.92,
              height: screenWidth * 1.35,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SmartCameraPreview(
                      controller: controller,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.accent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
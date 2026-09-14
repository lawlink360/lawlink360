
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import 'video_end_call_dialog.dart';

class VideoControlBar extends StatelessWidget {
  const VideoControlBar({super.key});

  Widget _controlButton(
    BuildContext context,
    IconData icon,
    Color background,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlButton(
            context,
            Icons.mic_off,
            Colors.white,
            Colors.black87,
          ),
          _controlButton(
            context,
            Icons.videocam_off,
            Colors.white,
            Colors.black87,
          ),
          _controlButton(
            context,
            Icons.cameraswitch,
            AppColors.accent,
            Colors.white,
          ),
          _controlButton(
            context,
            Icons.call_end,
            AppColors.error,
            Colors.white,
            onTap: () {
              VideoEndCallDialog.show(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'voice_end_call_dialog.dart';

class VoiceCallControlBar extends StatelessWidget {
  const VoiceCallControlBar({super.key});

  Widget _controlButton(
    BuildContext context,
    IconData icon,
    Color background,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 27,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlButton(
            context,
            Icons.mic_off_rounded,
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.onSurface,
          ),
          _controlButton(
            context,
            Icons.volume_up_rounded,
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.onSurface,
          ),
          _controlButton(
            context,
            Icons.bluetooth_audio_rounded,
            AppColors.accent,
            Colors.white,
          ),
          _controlButton(
            context,
            Icons.call_end_rounded,
            AppColors.error,
            Colors.white,
            onTap: () {
              VoiceEndCallDialog.show(context);
            },
          ),
        ],
      ),
    );
  }
}
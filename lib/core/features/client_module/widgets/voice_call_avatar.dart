import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class VoiceCallAvatar extends StatelessWidget {
  const VoiceCallAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent.withValues(alpha: 0.07),
          ),
        ),
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent.withValues(alpha: 0.14),
          ),
        ),
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surface,
            border: Border.all(
              color: AppColors.accent,
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.18),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.person_rounded,
            size: 86,
            color: colorScheme.primary,
          ),
        ),
        Positioned(
          right: 58,
          bottom: 58,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.surface,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
        ),
      ],
    );
  }
}
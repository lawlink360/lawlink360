import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class VoiceCallAppBar extends StatelessWidget {
  const VoiceCallAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Material(
            color: colorScheme.onSurface.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: SizedBox(
                width: 42,
                height: 42,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colorScheme.onSurface,
                  size: 18,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.call_rounded,
                  color: AppColors.success,
                  size: 16,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '00:00',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Material(
            color: colorScheme.onSurface.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: SizedBox(
                width: 42,
                height: 42,
                child: Icon(
                  Icons.more_vert_rounded,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
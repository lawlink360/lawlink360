import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatQuickActionBar extends StatelessWidget {
  const ChatQuickActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.25),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.18
                  : 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _QuickAction(
              Icons.attach_file_rounded,
              "File",
            ),
            _QuickAction(
              Icons.camera_alt_outlined,
              "Camera",
            ),
            _QuickAction(
              Icons.photo_outlined,
              "Gallery",
            ),
            _QuickAction(
              Icons.mic_none_rounded,
              "Voice",
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;

  const _QuickAction(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          title,
          style: AppTextStyles.caption.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
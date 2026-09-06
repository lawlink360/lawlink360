import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs / 2,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(
            AppRadius.lg,
          ),
          border: isMe
              ? null
              : Border.all(
                  color: AppColors.border,
                ),
        ),
        child: Text(
          message,
          style: AppTextStyles.body.copyWith(
            color: isMe
                ? AppColors.textLight
                : AppColors.textPrimary,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
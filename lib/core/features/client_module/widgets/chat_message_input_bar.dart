import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class ChatMessageInputBar extends StatelessWidget {
  const ChatMessageInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.14),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.55),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.12),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    borderSide: const BorderSide(
                      color: AppColors.accent,
                      width: 1.2,
                    ),
                  ),
                ),
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.20),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {},
                tooltip: 'Send message',
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
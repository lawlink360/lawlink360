import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class EmptyMessagesWidget extends StatelessWidget {
  const EmptyMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(
                  AppRadius.xl,
                ),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 46,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Text(
              'No Conversations Yet',
              textAlign: TextAlign.center,
              style: AppTextStyles.headline.copyWith(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: AppSpacing.sm,
            ),
            Text(
              'Start chatting with a lawyer and your conversations will appear here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface.withValues(
                  alpha: 0.65,
                ),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class RecentCaseCard extends StatelessWidget {
  const RecentCaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.gavel_rounded,
              color: Colors.deepPurple,
              size: 26,
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          Expanded(
            child: Text(
              'No active cases available.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.68),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
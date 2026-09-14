import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerConsultationCard extends StatelessWidget {
  const LawyerConsultationCard({super.key});

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(
                alpha: 0.10,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.md,
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.accent,
              size: 21,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: isDark ? 0.20 : 0.06,
            ),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
                child: const Icon(
                  Icons.medical_services_outlined,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Consultation Information',
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(
            height: 1,
            color: colorScheme.outline.withValues(
              alpha: 0.30,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _tile(
            context,
            Icons.video_call_outlined,
            'Video Consultation',
            'PKR 2500',
          ),
          _tile(
            context,
            Icons.call_outlined,
            'Voice Consultation',
            'PKR 1800',
          ),
          _tile(
            context,
            Icons.chat_bubble_outline_rounded,
            'Chat Consultation',
            'PKR 1200',
          ),
          _tile(
            context,
            Icons.schedule_outlined,
            'Response Time',
            '15 mins',
          ),
        ],
      ),
    );
  }
}
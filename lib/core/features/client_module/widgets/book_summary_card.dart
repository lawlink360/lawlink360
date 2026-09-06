import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookSummaryCard extends StatelessWidget {
  const BookSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.accent,
                  size: 21,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Appointment Summary',
                style: AppTextStyles.title.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _summaryRow(
            context,
            'Lawyer',
            'Adv. Ahmed Khan',
          ),
          _summaryRow(
            context,
            'Date',
            '21 July 2026',
          ),
          _summaryRow(
            context,
            'Time',
            '11:00 AM',
          ),
          _summaryRow(
            context,
            'Consultation',
            'In Person',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
            ),
            child: Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
          ),
          _summaryRow(
            context,
            'Consultation Fee',
            'Rs. 5,000',
          ),
          _summaryRow(
            context,
            'Platform Fee',
            'Rs. 300',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
            ),
            child: Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Rs. 5,300',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.accent,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String title,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookSummaryCard extends StatelessWidget {
  final Lawyer lawyer;
  final String consultationType;
  final String selectedDate;
  final String selectedTime;

  const BookSummaryCard({
    super.key,
    required this.lawyer,
    this.consultationType = 'In Person',
    this.selectedDate = 'Mon 21 July 2026',
    this.selectedTime = '11:00 AM',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final consultationFee = lawyer.consultationFee;
    const platformFee = 300.0;
    final total = consultationFee + platformFee;

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
          _summaryRow(context, 'Lawyer', lawyer.name),
          _summaryRow(context, 'Date', selectedDate),
          _summaryRow(context, 'Time', selectedTime),
          _summaryRow(context, 'Consultation', consultationType),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
          ),
          _summaryRow(
            context,
            'Consultation Fee',
            _formatAmount(consultationFee),
          ),
          _summaryRow(
            context,
            'Platform Fee',
            _formatAmount(platformFee),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
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
                _formatAmount(total),
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

  String _formatAmount(double amount) {
    return 'Rs. ${amount.toStringAsFixed(0)}';
  }

  Widget _summaryRow(
    BuildContext context,
    String title,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
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
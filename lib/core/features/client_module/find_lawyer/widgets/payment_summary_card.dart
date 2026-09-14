import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_radius.dart';
import '../../../../theme/app_spacing.dart';
import '../../../../theme/app_text_styles.dart';

class PaymentSummaryCard extends StatelessWidget {
  final Lawyer lawyer;
  final String consultationType;
  final String selectedDate;
  final String selectedTime;

  const PaymentSummaryCard({
    super.key,
    required this.lawyer,
    this.consultationType = 'In Person',
    this.selectedDate = 'Mon 21 July 2026',
    this.selectedTime = '11:00 AM',
  });

  Widget _row(
    BuildContext context,
    String title,
    String value, {
    bool isTotal = false,
    Color? color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: (isTotal
                      ? AppTextStyles.body
                      : AppTextStyles.bodySmall)
                  .copyWith(
                fontWeight:
                    isTotal ? FontWeight.w700 : FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            value,
            textAlign: TextAlign.end,
            style: (isTotal
                    ? AppTextStyles.title
                    : AppTextStyles.bodySmall)
                .copyWith(
              fontWeight:
                  isTotal ? FontWeight.w700 : FontWeight.w600,
              color: color ?? colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    return 'PKR ${amount.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const platformFee = 300.0;
    final consultationFee = lawyer.consultationFee;
    final total = consultationFee + platformFee;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.16
                  : 0.06,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appointment Summary',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.person_rounded,
                color: colorScheme.primary,
              ),
            ),
            title: Text(
              lawyer.name,
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              lawyer.speciality,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Divider(
            height: AppSpacing.lg,
            color: colorScheme.outline.withValues(alpha: 0.35),
          ),
          _row(
            context,
            'Consultation',
            consultationType,
          ),
          _row(
            context,
            'Date',
            selectedDate,
          ),
          _row(
            context,
            'Time',
            selectedTime,
          ),
          _row(
            context,
            'Consultation Fee',
            _formatAmount(consultationFee),
          ),
          _row(
            context,
            'Service Charges',
            _formatAmount(platformFee),
          ),
          const SizedBox(height: AppSpacing.xs),
          Divider(
            height: AppSpacing.lg,
            color: colorScheme.outline.withValues(alpha: 0.35),
          ),
          _row(
            context,
            'Total',
            _formatAmount(total),
            isTotal: true,
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }
}
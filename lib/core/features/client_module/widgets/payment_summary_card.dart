import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentSummaryCard extends StatelessWidget {
  const PaymentSummaryCard({super.key});

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            "Appointment Summary",
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
              "Adv. Ahmed Khan",
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              "Criminal Lawyer",
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
          _row(context, "Consultation", "Video Call"),
          _row(context, "Date", "20 July 2026"),
          _row(context, "Time", "11:00 AM"),
          _row(context, "Consultation Fee", "PKR 2,300"),
          _row(context, "Service Charges", "PKR 200"),
          const SizedBox(height: AppSpacing.xs),
          Divider(
            height: AppSpacing.lg,
            color: colorScheme.outline.withValues(alpha: 0.35),
          ),
          _row(
            context,
            "Total",
            "PKR 2,500",
            isTotal: true,
            color: AppColors.accent,
          ),
        ],
      ),
    );
  }
}
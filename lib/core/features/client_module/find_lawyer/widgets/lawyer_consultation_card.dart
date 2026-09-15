import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawyerConsultationCard extends StatelessWidget {
  final Lawyer? lawyer;

  const LawyerConsultationCard({
    super.key,
    this.lawyer,
  });

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String value, {
    bool highlighted = false,
  }) {
    final colorScheme =
        Theme.of(context).colorScheme;

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
              borderRadius:
                  BorderRadius.circular(
                AppRadius.md,
              ),
            ),
            child: Icon(
              icon,
              color: AppColors.accent,
              size: 21,
            ),
          ),
          const SizedBox(
            width: AppSpacing.md,
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                color:
                    colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            width: AppSpacing.sm,
          ),
          Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.bodySmall.copyWith(
              color: highlighted
                  ? AppColors.accent
                  : colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  String _feeText() {
    final fee = lawyer?.consultationFee ?? 0;

    if (fee <= 0) {
      return 'Contact lawyer';
    }

    return 'PKR ${fee.toStringAsFixed(0)}';
  }

  String _discountText() {
    final discount =
        lawyer?.discountPercent ?? 0;

    if (discount <= 0) {
      return 'No discount';
    }

    return '${discount.toStringAsFixed(0)}% OFF';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    final isAvailable =
        lawyer?.isOnline ?? true;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(
          AppRadius.xl,
        ),
        border: Border.all(
          color: colorScheme.outline.withValues(
            alpha: 0.45,
          ),
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
                  borderRadius:
                      BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
                child: const Icon(
                  Icons.event_available_outlined,
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              const SizedBox(
                width: AppSpacing.sm,
              ),
              Expanded(
                child: Text(
                  'Availability & Fees',
                  style: AppTextStyles.title.copyWith(
                    color: colorScheme.onSurface,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSpacing.md,
          ),
          Divider(
            height: 1,
            color: colorScheme.outline.withValues(
              alpha: 0.30,
            ),
          ),
          const SizedBox(
            height: AppSpacing.sm,
          ),
          _tile(
            context,
            Icons.today_outlined,
            'Available Today',
            isAvailable ? 'Available' : 'Unavailable',
            highlighted: isAvailable,
          ),
          _tile(
            context,
            Icons.payments_outlined,
            'Consultation Fee',
            _feeText(),
          ),
          _tile(
            context,
            Icons.local_offer_outlined,
            'Discount',
            _discountText(),
            highlighted:
                (lawyer?.discountPercent ?? 0) > 0,
          ),
          _tile(
            context,
            Icons.schedule_outlined,
            'Response Time',
            lawyer?.responseTime ?? '15 mins',
          ),
        ],
      ),
    );
  }
}

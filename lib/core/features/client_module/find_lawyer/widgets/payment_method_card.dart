import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

  Widget paymentTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    bool selected = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.accent.withValues(alpha: 0.06)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: selected
              ? AppColors.accent
              : colorScheme.outline.withValues(alpha: 0.22),
          width: selected ? 1.5 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.10),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.accent,
              size: 23,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_off_rounded,
            color: selected
                ? AppColors.accent
                : colorScheme.onSurfaceVariant,
            size: 23,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        paymentTile(
          context: context,
          icon: Icons.credit_card_rounded,
          title: 'Credit / Debit Card',
          subtitle: 'Visa • Mastercard • UnionPay',
          selected: true,
        ),
        paymentTile(
          context: context,
          icon: Icons.account_balance_wallet_rounded,
          title: 'JazzCash',
          subtitle: 'Pay using JazzCash Wallet',
        ),
        paymentTile(
          context: context,
          icon: Icons.phone_android_rounded,
          title: 'EasyPaisa',
          subtitle: 'Pay using EasyPaisa Wallet',
        ),
        paymentTile(
          context: context,
          icon: Icons.account_balance_rounded,
          title: 'Bank Transfer',
          subtitle: 'Online Bank Payment',
        ),
      ],
    );
  }
}
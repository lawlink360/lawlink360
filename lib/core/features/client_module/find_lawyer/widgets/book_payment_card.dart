import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/payment_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookPaymentCard extends StatelessWidget {
  final Lawyer lawyer;
  final String consultationType;
  final String selectedDate;
  final String selectedTime;

  const BookPaymentCard({
    super.key,
    required this.lawyer,
    this.consultationType = 'In Person',
    this.selectedDate = 'Mon 21 July 2026',
    this.selectedTime = '11:00 AM',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    const platformFee = 300.0;
    final total = lawyer.consultationFee + platformFee;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.2),
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
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Payable',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs / 2),
                  Text(
                    'PKR ${total.toStringAsFixed(0)}',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.accent,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(
              height: AppSpacing.buttonHeight,
              width: 160,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        lawyer: lawyer,
                        consultationType: consultationType,
                        selectedDate: selectedDate,
                        selectedTime: selectedTime,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.lock_outline_rounded,
                  size: 19,
                ),
                label: Text(
                  'Confirm',
                  style: AppTextStyles.button.copyWith(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
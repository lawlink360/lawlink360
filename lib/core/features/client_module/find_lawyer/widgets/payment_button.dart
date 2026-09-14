import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/booking_success_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class PaymentButton extends StatelessWidget {
  final Lawyer lawyer;
  final String consultationType;
  final String selectedDate;
  final String selectedTime;

  const PaymentButton({
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
        padding: const EdgeInsets.all(AppSpacing.md),
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
        child: SizedBox(
          height: AppSpacing.buttonHeight,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingSuccessScreen(
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
              size: 20,
            ),
            label: Text(
              'Pay PKR ${total.toStringAsFixed(0)}',
              style: AppTextStyles.button.copyWith(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
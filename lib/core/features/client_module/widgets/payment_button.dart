import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/screens/booking_success_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
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
              debugPrint('PAY BUTTON PRESSED');

              final navigator = Navigator.of(context);

              debugPrint('Navigator found: $navigator');

              navigator.push(
                MaterialPageRoute(
                  builder: (context) {
                    debugPrint('BUILDING SUCCESS SCREEN');
                    return const BookingSuccessScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.lock_outline_rounded,
              size: 20,
            ),
            label: Text(
              'Pay PKR 5,300',
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
                borderRadius: BorderRadius.circular(
                  AppRadius.md,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
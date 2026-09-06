import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/screens/payment_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class BookConfirmButton extends StatelessWidget {
  const BookConfirmButton({super.key});

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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigating to Payment...'),
                  duration: Duration(milliseconds: 800),
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.calendar_month_rounded,
              size: 21,
            ),
            label: Text(
              'Confirm Booking',
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
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/payment_coupon_card.dart';
import '../widgets/payment_security_card.dart';
import '../widgets/payment_button.dart';

class PaymentScreen extends StatelessWidget {
  final Lawyer lawyer;
  final String consultationType;
  final String selectedDate;
  final String selectedTime;

  const PaymentScreen({
    super.key,
    required this.lawyer,
    this.consultationType = 'In Person',
    this.selectedDate = 'Mon 21 July 2026',
    this.selectedTime = '11:00 AM',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Secure Payment',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            PaymentSummaryCard(
              lawyer: lawyer,
              consultationType: consultationType,
              selectedDate: selectedDate,
              selectedTime: selectedTime,
            ),
            const SizedBox(height: AppSpacing.lg),
            const PaymentMethodCard(),
            const SizedBox(height: AppSpacing.lg),
            const PaymentCouponCard(),
            const SizedBox(height: AppSpacing.lg),
            const PaymentSecurityCard(),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: PaymentButton(
        lawyer: lawyer,
        consultationType: consultationType,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
      ),
    );
  }
}
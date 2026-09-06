
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/payment_coupon_card.dart';
import '../widgets/payment_security_card.dart';
import '../widgets/payment_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
          children: const [
            PaymentSummaryCard(),
            SizedBox(height: AppSpacing.lg),
            PaymentMethodCard(),
            SizedBox(height: AppSpacing.lg),
            PaymentCouponCard(),
            SizedBox(height: AppSpacing.lg),
            PaymentSecurityCard(),
            SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: const PaymentButton(),
    );
  }
}

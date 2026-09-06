
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/book_lawyer_profile_header.dart';
import '../widgets/book_consultation_type.dart';
import '../widgets/book_date_card.dart';
import '../widgets/book_time_slot.dart';
import '../widgets/book_summary_card.dart';
import '../widgets/book_payment_card.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

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
          'Book Appointment',
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
            LawyerProfileHeader(),
            SizedBox(height: AppSpacing.lg),
            BookConsultationType(),
            SizedBox(height: AppSpacing.lg),
            BookDateCard(),
            SizedBox(height: AppSpacing.lg),
            BookTimeSlot(),
            SizedBox(height: AppSpacing.lg),
            BookSummaryCard(),
            SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: const BookPaymentCard(),
    );
  }
}

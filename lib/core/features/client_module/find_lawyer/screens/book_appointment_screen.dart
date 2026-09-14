import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';

import 'package:lawlink360/core/theme/app_colors.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';

import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/book_lawyer_profile_header.dart';

import '../widgets/book_consultation_type.dart';

import '../widgets/book_date_card.dart';

import '../widgets/book_time_slot.dart';

import '../widgets/book_summary_card.dart';

import '../widgets/book_payment_card.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Lawyer lawyer;

  const BookAppointmentScreen({super.key, required this.lawyer});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String _selectedConsultationType = 'In Person';
  String _selectedDate = 'Mon 21 July 2026';
  String _selectedTime = '11:00 AM';

  @override
  Widget build(BuildContext context) {
    final lawyer = widget.lawyer;

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
          children: [
            LawyerProfileHeader(lawyer: lawyer),

            const SizedBox(height: AppSpacing.lg),

            BookConsultationType(
              onChanged: (type) {
                setState(() {
                  _selectedConsultationType = type;
                });
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            BookDateCard(
              onChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            BookTimeSlot(
              onChanged: (time) {
                setState(() {
                  _selectedTime = time;
                });
              },
            ),

            const SizedBox(height: AppSpacing.lg),

            BookSummaryCard(
              lawyer: lawyer,
              consultationType: _selectedConsultationType,
              selectedDate: _selectedDate,
              selectedTime: _selectedTime,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
      bottomNavigationBar: BookPaymentCard(
        lawyer: lawyer,
        consultationType: _selectedConsultationType,
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
      ),
    );
  }
}

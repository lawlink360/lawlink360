import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/lawyer_about_card.dart';
import '../widgets/lawyer_booking_button.dart';
import '../widgets/lawyer_certificates_card.dart';
import '../widgets/lawyer_consultation_card.dart';
import '../widgets/lawyer_education_card.dart';
import '../widgets/lawyer_enrollment_card.dart';
import '../widgets/lawyer_experience_card.dart';
import '../widgets/lawyer_languages_card.dart';
import '../widgets/lawyer_practice_areas_card.dart';
import '../widgets/lawyer_profile_header.dart';
import '../widgets/lawyer_rating_summary_card.dart';
import '../widgets/lawyer_reviews_card.dart';

class LawyerDetailsReviewsScreen extends StatelessWidget {
  const LawyerDetailsReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Lawyer Details',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorScheme.onSurface,
          ),
          tooltip: 'Back',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const LawyerProfileHeader(),

              const LawyerAboutCard(),

              const LawyerPracticeAreasCard(),

              const LawyerRatingSummaryCard(),

              const LawyerReviewsCard(),

              const LawyerEducationCard(),

              const LawyerExperienceCard(),

              const LawyerCertificatesCard(),

              const LawyerLanguagesCard(),

              const LawyerEnrollmentCard(),

              const LawyerConsultationCard(),

              const SizedBox(height: AppSpacing.xxl),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LawyerBookingButton(),
    );
  }
}
import 'package:flutter/material.dart';

import '../widgets/lawyer_profile_header.dart';
import '../widgets/lawyer_about_card.dart';
import '../widgets/lawyer_practice_areas_card.dart';
import '../widgets/lawyer_rating_summary_card.dart';
import '../widgets/lawyer_reviews_card.dart';
import '../widgets/lawyer_education_card.dart';
import '../widgets/lawyer_experience_card.dart';
import '../widgets/lawyer_certificates_card.dart';
import '../widgets/lawyer_languages_card.dart';
import '../widgets/lawyer_enrollment_card.dart';
import '../widgets/lawyer_consultation_card.dart';
import '../widgets/lawyer_booking_button.dart';

class LawyerDetailsReviewsScreen extends StatelessWidget {
  const LawyerDetailsReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Lawyer Details",
          style: TextStyle(
            color: Color(0xff0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const SingleChildScrollView(
  child: Column(
    children: [
      LawyerProfileHeader(),
      LawyerAboutCard(),
      LawyerPracticeAreasCard(),
      const LawyerRatingSummaryCard(),
      const LawyerReviewsCard(),
      const LawyerEducationCard(),

const LawyerExperienceCard(),

const LawyerCertificatesCard(),

const LawyerLanguagesCard(),

const LawyerEnrollmentCard(),

const LawyerConsultationCard(),

const SizedBox(height:120),
    ],
  ),
),
bottomNavigationBar: const LawyerBookingButton(),
    );
  }
}
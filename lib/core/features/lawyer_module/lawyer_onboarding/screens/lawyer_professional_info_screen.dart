import 'package:flutter/material.dart';

import '../widgets/professional/professional_info_practice_area.dart';
import '../widgets/professional/professional_info_experience.dart';
import '../widgets/professional/professional_info_license_number.dart';
import '../widgets/professional/professional_info_court_selector.dart';
import '../widgets/professional/professional_info_about.dart';

import 'lawyer_verification_screen.dart';

class LawyerProfessionalInfoScreen extends StatelessWidget {
  const LawyerProfessionalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Professional Information',
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // --------------------------------------------------
              // INTRODUCTION
              // --------------------------------------------------
              Text(
                'Build Your Professional Profile',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),

              SizedBox(height: 8),

              Text(
                'Tell clients about your legal expertise, experience, '
                'and the courts where you practice.',
                style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
              ),

              SizedBox(height: 24),

              // --------------------------------------------------
              // PRACTICE AREAS
              // --------------------------------------------------
              ProfessionalInfoPracticeArea(),

              SizedBox(height: 20),

              // --------------------------------------------------
              // EXPERIENCE
              // --------------------------------------------------
              ProfessionalInfoExperience(),

              SizedBox(height: 20),

              // --------------------------------------------------
              // LICENSE
              // --------------------------------------------------
              ProfessionalInfoLicenseNumber(),

              SizedBox(height: 20),

              // --------------------------------------------------
              // COURTS
              // --------------------------------------------------
              ProfessionalInfoCourtSelector(),

              SizedBox(height: 20),

              // --------------------------------------------------
              // ABOUT LAWYER
              // --------------------------------------------------
              ProfessionalInfoAbout(),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // ----------------------------------------------------------
      // CONTINUE BUTTON
      // ----------------------------------------------------------
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LawyerVerificationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: const Color(0xFF0D1B2A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


import '../widgets/onboarding/onboarding_progress.dart';
import '../widgets/verification/verification_intro_card.dart';
import '../widgets/verification/verification_bar_card.dart';
import '../widgets/verification/verification_id_card.dart';
import '../widgets/verification/verification_privacy_notice.dart';
import '../widgets/verification/verification_status_card.dart';
import '../widgets/verification/verification_submit_button.dart';


class LawyerVerificationScreen extends StatelessWidget {
  const LawyerVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Credential Verification',
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify Your Credentials',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Help us verify your professional identity before your lawyer profile becomes available to clients.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const OnboardingProgress(currentStep: 4, totalSteps: 5),

            const SizedBox(height: 24),

            const VerificationIntroCard(),

            const SizedBox(height: 20),

            const VerificationBarCard(),

            const SizedBox(height: 20),

            const VerificationIdCard(),

            const SizedBox(height: 20),

            const VerificationPrivacyNotice(),

            const SizedBox(height: 20),

            const VerificationStatusCard(),

            const SizedBox(height: 24),

            VerificationSubmitButton(
  onSubmitted: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const VerificationSubmitButton(),
      ),
    );
  },
),

            const SizedBox(height: 12),

            const Text(
              'By submitting these documents, you confirm that '
              'the information provided is accurate and belongs to you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.5, color: Colors.grey, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

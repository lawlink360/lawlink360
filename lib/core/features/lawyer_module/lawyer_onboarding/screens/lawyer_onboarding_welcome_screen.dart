import 'package:flutter/material.dart';

import '../widgets/onboarding/onboarding_header.dart';
import '../widgets/onboarding/onboarding_progress.dart';
import '../widgets/onboarding/onboarding_intro_card.dart';
import '../widgets/onboarding/onboarding_continue_button.dart';
import 'lawyer_basic_info_screen.dart';

class LawyerOnboardingWelcomeScreen extends StatelessWidget {
  const LawyerOnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Lawyer Profile',
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const OnboardingProgress(),

            const SizedBox(height: 28),

            const OnboardingHeader(),

            const SizedBox(height: 28),

            const OnboardingIntroCard(),

            const SizedBox(height: 30),

            const Text(
              'Your profile will be visible to clients and help them decide whether your legal services are right for their needs.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            OnboardingContinueButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LawyerBasicInfoScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

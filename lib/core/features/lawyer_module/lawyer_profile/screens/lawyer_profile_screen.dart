import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/widgets/cards/lawyer_about_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/widgets/cards/lawyer_contact_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/widgets/cards/lawyer_languages_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/widgets/cards/lawyer_practice_areas_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/widgets/profile/lawyer_profile_header.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/widgets/profile/lawyer_profile_stats.dart';

class LawyerProfileScreen extends ConsumerWidget {
  const LawyerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(lawyerOnboardingProvider);

    final practiceAreas = ref
        .read(lawyerOnboardingProvider.notifier)
        .professionalInfo
        .practiceAreas;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Color(0xFF0F1B35),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF0F1B35),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF0F1B35),
            ),
            onPressed: () {
              // Edit profile will be connected later.
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LawyerProfileHeader(),
            const SizedBox(height: 16),
            const LawyerProfileStats(),
            const SizedBox(height: 28),
            const LawyerAboutCard(),
            const SizedBox(height: 24),
            const LawyerContactCard(),
            const SizedBox(height: 24),
            LawyerPracticeAreasCard(
              practiceAreas: practiceAreas,
            ),
            const SizedBox(height: 24),
            const LawyerLanguagesCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:lawlink360/widgets/cards/lawyer_profile_header.dart';
import 'package:lawlink360/widgets/inputs/lawyer_quick_action.dart';
import 'package:lawlink360/widgets/cards/lawyer_about_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_stats_card.dart';
import 'package:lawlink360/widgets/navigation/lawyer_practice_chip.dart';
import 'package:lawlink360/widgets/cards/lawyer_education_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_review_card.dart';
import 'package:lawlink360/widgets/appbar/lawyer_bottom_action_bar.dart';



class LawyerProfileScreen extends StatelessWidget {
  const LawyerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              /// Header
              ProfileHeader(),

              SizedBox(height: 24),

              /// Quick Actions
              QuickActions(),

              SizedBox(height: 30),

               AboutLawyerCard(),

               SizedBox(height: 28),

               StatsCard(),

               SizedBox(height: 25),

               LawyerPracticeChip(),

               SizedBox(height: 25),

               LawyerEducationCard(),

               SizedBox(height: 25),

               LawyerReviewCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LawyerBottomActionBar(),
    );
  }
}

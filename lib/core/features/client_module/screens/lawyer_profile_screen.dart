import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'package:lawlink360/widgets/appbar/lawyer_bottom_action_bar.dart';
import 'package:lawlink360/widgets/cards/lawyer_about_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_education_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_profile_header.dart';
import 'package:lawlink360/widgets/cards/lawyer_review_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_stats_card.dart';
import 'package:lawlink360/widgets/inputs/lawyer_quick_action.dart';
import 'package:lawlink360/widgets/navigation/lawyer_practice_chip.dart';

class LawyerProfileScreen extends StatelessWidget {
  const LawyerProfileScreen({super.key});

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
          'Lawyer Profile',
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
              const ProfileHeader(),

              const SizedBox(height: AppSpacing.lg),

              const QuickActions(),

              const SizedBox(height: AppSpacing.xxl),

              const AboutLawyerCard(),

              const SizedBox(height: AppSpacing.lg),

              const StatsCard(),

              const SizedBox(height: AppSpacing.lg),

              const LawyerPracticeChip(),

              const SizedBox(height: AppSpacing.lg),

              const LawyerEducationCard(),

              const SizedBox(height: AppSpacing.lg),

              const LawyerReviewCard(),

              const SizedBox(height: AppSpacing.xxl),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.xxl,
                ),
                child: Text(
                  'LawLink360 • Trusted Digital Legal Partner',
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LawyerBottomActionBar(),
    );
  }
}
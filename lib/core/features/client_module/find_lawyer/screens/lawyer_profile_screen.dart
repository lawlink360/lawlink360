import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_about_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_certificates_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_consultation_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_enrollment_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_experience_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_languages_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_profile_header.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_rating_summary_card.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'package:lawlink360/widgets/appbar/lawyer_bottom_action_bar.dart';
import 'package:lawlink360/widgets/cards/lawyer_education_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_review_card.dart';
import 'package:lawlink360/widgets/cards/lawyer_stats_card.dart';
import 'package:lawlink360/widgets/inputs/lawyer_quick_action.dart';
import 'package:lawlink360/widgets/navigation/lawyer_practice_chip.dart';

class LawyerProfileScreen extends ConsumerStatefulWidget {
  final Lawyer? lawyer;

  const LawyerProfileScreen({
    super.key,
    this.lawyer,
  });

  @override
  ConsumerState<LawyerProfileScreen> createState() =>
      _LawyerProfileScreenState();
}

class _LawyerProfileScreenState
    extends ConsumerState<LawyerProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final lawyer = widget.lawyer;

      if (lawyer != null) {
        ref.read(recentlyViewedProvider.notifier).add(lawyer);
      }
    });
  }

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
              LawyerProfileHeader(
                lawyer: widget.lawyer,
              ),
              const SizedBox(height: AppSpacing.lg),

              const QuickActions(),
              const SizedBox(height: AppSpacing.xxl),

              LawyerAboutCard(
                lawyer: widget.lawyer,
              ),
              const SizedBox(height: AppSpacing.lg),

              StatsCard(
                lawyer: widget.lawyer,
              ),
              const SizedBox(height: AppSpacing.lg),

              LawyerPracticeChip(
                lawyer: widget.lawyer,
              ),
              const SizedBox(height: AppSpacing.lg),

              LawyerEducationCard(
                lawyer: widget.lawyer,
              ),
              const SizedBox(height: AppSpacing.lg),

              const LawyerExperienceCard(),
              const SizedBox(height: AppSpacing.lg),

              const LawyerCertificatesCard(),
              const SizedBox(height: AppSpacing.lg),

              const LawyerLanguagesCard(),
              const SizedBox(height: AppSpacing.lg),

              const LawyerEnrollmentCard(),
              const SizedBox(height: AppSpacing.lg),

              const LawyerRatingSummaryCard(),
              const SizedBox(height: AppSpacing.lg),

              const LawyerReviewCard(),
              const SizedBox(height: AppSpacing.lg),

              const LawyerConsultationCard(),
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

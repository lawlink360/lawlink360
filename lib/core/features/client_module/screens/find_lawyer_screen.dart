import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/hero_section.dart';
import '../widgets/practice_area_card.dart';
import '../widgets/lawyer_card.dart';

class FindLawyerScreen extends StatelessWidget {
  const FindLawyerScreen({super.key});

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
          'Find Lawyer',
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
          padding: const EdgeInsets.only(
            bottom: AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeroSection(),

              const SizedBox(height: AppSpacing.lg),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: _SearchField(
                  colorScheme: colorScheme,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              _SectionTitle(
                title: 'Practice Areas',
                color: colorScheme.onSurface,
              ),

              const SizedBox(height: AppSpacing.md),

              SizedBox(
                height: 180,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    PracticeAreaCard(
                      icon: Icons.gavel_rounded,
                      title: 'Criminal',
                      lawyers: '120 Lawyers',
                    ),
                    PracticeAreaCard(
                      icon: Icons.family_restroom_rounded,
                      title: 'Family',
                      lawyers: '95 Lawyers',
                    ),
                    PracticeAreaCard(
                      icon: Icons.description_rounded,
                      title: 'Civil',
                      lawyers: '110 Lawyers',
                    ),
                    PracticeAreaCard(
                      icon: Icons.account_balance_rounded,
                      title: 'Corporate',
                      lawyers: '72 Lawyers',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              _SectionTitle(
                title: 'Top Rated Lawyers',
                color: colorScheme.onSurface,
              ),

              const SizedBox(height: AppSpacing.md),

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Column(
                  children: [
                    LawyerCard(
                      name: 'Adv. Ahmed Khan',
                      speciality: 'Criminal Lawyer',
                      location: 'Islamabad',
                      rating: 4.9,
                      experience: 15,
                    ),
                    LawyerCard(
                      name: 'Adv. Sara Malik',
                      speciality: 'Family Lawyer',
                      location: 'Lahore',
                      rating: 4.8,
                      experience: 11,
                    ),
                    LawyerCard(
                      name: 'Adv. Ali Raza',
                      speciality: 'Civil Lawyer',
                      location: 'Karachi',
                      rating: 4.7,
                      experience: 9,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: _PostCaseCard(
                  colorScheme: colorScheme,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ColorScheme colorScheme;

  const _SearchField({
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search lawyer by name or specialty',
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: colorScheme.primary,
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.tune_rounded,
            color: colorScheme.primary,
          ),
          tooltip: 'Filter lawyers',
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.55,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.25),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(
            color: AppColors.accent,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: Text(
        title,
        style: AppTextStyles.headline.copyWith(
          color: color,
          fontSize: 23,
        ),
      ),
    );
  }
}

class _PostCaseCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _PostCaseCard({
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.25
                  : 0.10,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.support_agent_rounded,
            color: AppColors.accent,
            size: 30,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "Can't Find the Right Lawyer?",
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Post your legal case and receive proposals from verified lawyers across Pakistan.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.gavel_rounded,
                size: 20,
              ),
              label: Text(
                'Post Your Case',
                style: AppTextStyles.button.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppRadius.md,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
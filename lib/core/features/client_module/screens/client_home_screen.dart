import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/activity/recent_activity_section.dart';
import 'package:lawlink360/core/features/client_module/cases/my_cases_section.dart';
import 'package:lawlink360/core/features/client_module/client_dashboard/widgets/upcoming_appointments_card.dart';
import 'package:lawlink360/core/features/client_module/widgets/app_drawer.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/popular_services_section.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/copy_house_landing_screen.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';
import 'package:lawlink360/widgets/appbar/ai_search_bar.dart' as ai_search;
import 'package:lawlink360/widgets/cards/home_header.dart' as home_header;
import 'package:lawlink360/widgets/navigation/quick_action_grid.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // ------------------------------------------------------------
              // HOME HEADER + OVERLAPPING AI SEARCH
              // ------------------------------------------------------------
              SizedBox(
                height: 360, // CHANGED: Increased height for subtitle
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Home Header with subtitle
                    const Align(
                      alignment: Alignment.topCenter,
                      child: home_header.HomeHeader(
                        greeting: 'Good Morning 👋',
                        name: 'King Shaheer',
                        subtitle: "Welcome to Pakistan's best Legal Platform", // ADDED subtitle
                      ),
                    ),

                    // AI Search overlaps the lower portion of the header
                    const Positioned(
                      left: 0,
                      right: 0,
                      bottom: -25, // Slightly adjusted for better overlap
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                        child: ai_search.AISearchBar(),
                      ),
                    ),
                  ],
                ),
              ),

              // ------------------------------------------------------------
              // QUICK ACTIONS - Proper spacing
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.xxl),

              _SectionTitle(
                title: 'Quick Actions',
                color: colorScheme.onSurface,
              ),

              const SizedBox(height: AppSpacing.md),

              const QuickActionsGrid(),

              // ------------------------------------------------------------
              // UPCOMING APPOINTMENTS
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.lg),

              const UpcomingAppointmentCard(),

              // ------------------------------------------------------------
              // MY CASES
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.lg),

              const MyCasesSection(),

              // ------------------------------------------------------------
              // COPY HOUSE
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.lg),

              _SectionTitle(
                title: 'Copy House',
                color: colorScheme.onSurface,
              ),

              const SizedBox(height: AppSpacing.md),

              _CopyHouseEntry(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CopyHouseLandingScreen(),
                    ),
                  );
                },
              ),


              // ------------------------------------------------------------
              // POPULAR SERVICES
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.lg),

              const PopularServicesSection(),

              // ------------------------------------------------------------
              // RECENT ACTIVITY
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.lg),

              const RecentActivitySection(),

              // ------------------------------------------------------------
              // FOOTER
              // ------------------------------------------------------------
              const SizedBox(height: AppSpacing.xxl),

              _Footer(
                primaryColor: colorScheme.primary,
                secondaryColor: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextStyles.headline.copyWith(color: color, fontSize: 24),
        ),
      ),
    );
  }
}

// ============================================================================
// COPY HOUSE ENTRY
// ============================================================================

class _CopyHouseEntry extends StatelessWidget {
  final VoidCallback onTap;

  const _CopyHouseEntry({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.55),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.business_center_outlined,
                  color: colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Copy House by LawLink360',
                        style: AppTextStyles.body.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Certified Copies • Official Records • Registered Documents',
                        style: AppTextStyles.caption.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurface.withValues(alpha: 0.42),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FOOTER
// ============================================================================

class _Footer extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const _Footer({required this.primaryColor, required this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
      child: Column(
        children: [
          Text(
            'LawLink360',
            style: AppTextStyles.title.copyWith(color: primaryColor),
          ),

          const SizedBox(height: AppSpacing.xs),

          Text(
            'Your Trusted Digital Legal Partner',
            style: AppTextStyles.caption.copyWith(color: secondaryColor),
          ),

          const SizedBox(height: AppSpacing.sm),

          Text(
            'Version 1.0.0 • © 2026 LawLink360',
            style: AppTextStyles.caption.copyWith(color: secondaryColor),
          ),
        ],
      ),
    );
  }
}
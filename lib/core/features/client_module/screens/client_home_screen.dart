import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/activity/recent_activity_section.dart';
import 'package:lawlink360/core/features/client_module/cases/my_cases_section.dart';
import 'package:lawlink360/core/features/client_module/widgets/app_drawer.dart';
import 'package:lawlink360/core/features/client_module/widgets/popular_services_section.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';
import 'package:lawlink360/widgets/appbar/ai_search_bar.dart';
import 'package:lawlink360/core/features/client_module/client_dashboard/widgets/upcoming_appointments_card.dart';
import 'package:lawlink360/widgets/cards/home_header.dart';
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
              const HomeHeader(
                greeting: 'Good Morning 👋',
                name: 'King Shaheer',
              ),
              Transform.translate(
                offset: const Offset(0, -30),
                child: const AISearchBar(),
              ),
              const SizedBox(height: AppSpacing.xs),
              _SectionTitle(
                title: 'Quick Actions',
                color: colorScheme.onSurface,
              ),
              const SizedBox(height: AppSpacing.md),
              const QuickActionsGrid(),
              const SizedBox(height: AppSpacing.lg),
              const UpcomingAppointmentCard(),
              const SizedBox(height: AppSpacing.lg),
              const MyCasesSection(),
              const SizedBox(height: AppSpacing.lg),
              const PopularServicesSection(),
              const SizedBox(height: AppSpacing.lg),
              const RecentActivitySection(),
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
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextStyles.headline.copyWith(
            color: color,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const _Footer({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.xxl,
      ),
      child: Column(
        children: [
          Text(
            'LawLink360',
            style: AppTextStyles.title.copyWith(
              color: primaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Your Trusted Digital Legal Partner',
            style: AppTextStyles.caption.copyWith(
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Version 1.0.0 • © 2026 LawLink360',
            style: AppTextStyles.caption.copyWith(
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/dashboard_data.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_statistics.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/recent_case_card.dart';
import '../widgets/upcoming_appointments_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = DashboardData.statistics;
    final activities = DashboardData.activities;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          const DashboardHeader(
            name: 'LawLink User',
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: DashboardStatistics(
                  icon: stats[0].icon,
                  color: stats[0].color,
                  title: stats[0].title,
                  value: stats[0].value,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: DashboardStatistics(
                  icon: stats[1].icon,
                  color: stats[1].color,
                  title: stats[1].title,
                  value: stats[1].value,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: DashboardStatistics(
                  icon: stats[2].icon,
                  color: stats[2].color,
                  title: stats[2].title,
                  value: stats[2].value,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: DashboardStatistics(
                  icon: stats[3].icon,
                  color: stats[3].color,
                  title: stats[3].title,
                  value: stats[3].value,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle(title: 'Quick Actions'),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: QuickActionsCard(
                  icon: Icons.search_rounded,
                  title: 'Find Lawyer',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: QuickActionsCard(
                  icon: Icons.document_scanner_outlined,
                  title: 'Scanner',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: QuickActionsCard(
                  icon: Icons.translate_rounded,
                  title: 'Translate',
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle(title: 'Recent Activity'),
          const SizedBox(height: AppSpacing.sm),
          ...activities.map(
            (activity) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: RecentActivityCard(
                title: activity.title,
                subtitle: activity.subtitle,
                time: activity.time,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionTitle(title: 'Upcoming Appointment'),
          const SizedBox(height: AppSpacing.sm),
          const UpcomingAppointmentCard(),
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle(title: 'Recent Case'),
          const SizedBox(height: AppSpacing.sm),
          const RecentCaseCard(),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.title.copyWith(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

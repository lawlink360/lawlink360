import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/appointment_data.dart';
import '../widgets/appointment_calendar_card.dart';
import '../widgets/appointment_card.dart';
import '../widgets/appointment_filter_tabs.dart';
import '../widgets/appointment_search_bar.dart';
import '../widgets/appointment_statistics_card.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: colorScheme.outlineVariant.withValues(alpha: 0.45),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const AppointmentCalendarCard(),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Find an Appointment',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          const AppointmentSearchBar(),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Appointment Overview',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              const AppointmentStatisticsCards(
                title: 'Today',
                value: '1',
                icon: Icons.today_rounded,
                color: AppColors.error,
              ),
              const SizedBox(width: AppSpacing.sm),
              const AppointmentStatisticsCards(
                title: 'Upcoming',
                value: '1',
                icon: Icons.schedule_rounded,
                color: AppColors.success,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              const AppointmentStatisticsCards(
                title: 'Completed',
                value: '1',
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.info,
              ),
              const SizedBox(width: AppSpacing.sm),
              AppointmentStatisticsCards(
                title: 'Cancelled',
                value: '1',
                icon: Icons.cancel_outlined,
                color: colorScheme.onSurface.withValues(alpha: 0.48),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Your Appointments',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          AppointmentFilterTabs(
            selectedIndex: selectedTab,
            onChanged: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),

          const SizedBox(height: AppSpacing.md),

          ...AppointmentData.appointments.map(
            (appointment) => AppointmentCard(
              appointment: appointment,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.045),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.10),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 19,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Your appointment information is securely organized in one place.',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
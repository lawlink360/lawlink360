import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../providers/appointment_filter_provider.dart';
import '../providers/appointment_providers.dart';
import '../widgets/appointment_calendar_card.dart';
import '../widgets/appointment_card.dart';
import '../widgets/appointment_filter_tabs.dart';
import '../widgets/appointment_search_bar.dart';
import '../widgets/appointment_statistics_card.dart';
import 'package:lawlink360/core/features/client_module/appointments/screens/appointment_details_screen.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final statistics = ref.watch(appointmentStatisticsProvider);
    final filteredAppointments =
        ref.watch(filteredAppointmentsProvider);
    final selectedFilter =
        ref.watch(appointmentFilterProvider);

    final selectedTab = switch (selectedFilter) {
      AppointmentFilter.all => 0,
      AppointmentFilter.today => 0,
      AppointmentFilter.upcoming => 1,
      AppointmentFilter.completed => 2,
      AppointmentFilter.cancelled => 3,
    };

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
            color: colorScheme.outlineVariant.withValues(
              alpha: 0.45,
            ),
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
              Expanded(
                child: AppointmentStatisticsCards(
                  title: 'Today',
                  value: '${statistics.today}',
                  icon: Icons.today_rounded,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppointmentStatisticsCards(
                  title: 'Upcoming',
                  value: '${statistics.upcoming}',
                  icon: Icons.schedule_rounded,
                  color: AppColors.success,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              Expanded(
                child: AppointmentStatisticsCards(
                  title: 'Completed',
                  value: '${statistics.completed}',
                  icon: Icons.check_circle_outline_rounded,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppointmentStatisticsCards(
                  title: 'Cancelled',
                  value: '${statistics.cancelled}',
                  icon: Icons.cancel_outlined,
                  color: colorScheme.onSurface.withValues(
                    alpha: 0.48,
                  ),
                ),
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
              final notifier = ref.read(
                appointmentFilterProvider.notifier,
              );

              switch (index) {
                case 0:
                  notifier.showAll();
                  break;
                case 1:
                  notifier.showUpcoming();
                  break;
                case 2:
                  notifier.showCompleted();
                  break;
                case 3:
                  notifier.showCancelled();
                  break;
              }
            },
          ),

          const SizedBox(height: AppSpacing.md),

          if (filteredAppointments.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.xl,
              ),
              child: Center(
                child: Text(
                  'No appointments found.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface.withValues(
                      alpha: 0.60,
                    ),
                  ),
                ),
              ),
            )
          else
            ...filteredAppointments.map(
              (appointment) => AppointmentCard(
                appointment: appointment,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AppointmentDetailsScreen(
                        appointment: appointment,
                      ),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: AppSpacing.md),

          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(
                alpha: 0.045,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.lg,
              ),
              border: Border.all(
                color: colorScheme.primary.withValues(
                  alpha: 0.10,
                ),
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
                      color: colorScheme.onSurface.withValues(
                        alpha: 0.65,
                      ),
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

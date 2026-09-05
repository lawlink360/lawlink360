import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_appointments/models/appointment_status_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/providers/admin_appointments_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/screens/admin_appointment_details_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/widgets/admin_appointment_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/widgets/appointment_filter_sheet.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/widgets/appointment_stats_card.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminAppointmentsScreen extends ConsumerStatefulWidget {
  const AdminAppointmentsScreen({
    super.key,
  });

  @override
  ConsumerState<AdminAppointmentsScreen> createState() =>
      _AdminAppointmentsScreenState();
}

class _AdminAppointmentsScreenState
    extends ConsumerState<AdminAppointmentsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentsState = ref.watch(adminAppointmentsProvider);
    final notifier = ref.read(adminAppointmentsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: notifier.refresh,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: 3,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: appointmentsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _ErrorView(
          onRetry: notifier.refresh,
        ),
        data: (appointments) {
          return RefreshIndicator(
            onRefresh: () async {
              notifier.refresh();

              await Future<void>.delayed(
                const Duration(milliseconds: 350),
              );
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildStats(notifier),
                const SizedBox(height: 20),
                _buildSearchAndFilter(
                  context,
                  notifier,
                ),
                const SizedBox(height: 16),
                if (appointments.isEmpty)
                  const _EmptyAppointmentsView()
                else
                  ...appointments.map(
                    (appointment) {
                      return AdminAppointmentCard(
                        appointment: appointment,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AdminAppointmentDetailsScreen(
                                appointmentId: appointment.id,
                              ),
                            ),
                          );
                        },
                        onConfirm: appointment.status ==
                                AppointmentStatusModel.pending.value
                            ? () {
                                notifier.updateStatus(
                                  appointment.id,
                                  AppointmentStatusModel.confirmed.value,
                                );
                              }
                            : null,
                        onComplete: appointment.status ==
                                    AppointmentStatusModel.confirmed.value ||
                                appointment.status ==
                                    AppointmentStatusModel.pending.value
                            ? () {
                                notifier.updateStatus(
                                  appointment.id,
                                  AppointmentStatusModel.completed.value,
                                );
                              }
                            : null,
                        onCancel: appointment.status !=
                                    AppointmentStatusModel.cancelled.value &&
                                appointment.status !=
                                    AppointmentStatusModel.completed.value
                            ? () {
                                notifier.updateStatus(
                                  appointment.id,
                                  AppointmentStatusModel.cancelled.value,
                                );
                              }
                            : null,
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Management',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Monitor and manage client-lawyer appointments.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
      ],
    );
  }

  Widget _buildStats(
    AdminAppointmentsNotifier notifier,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppointmentStatsCard(
                title: 'Total',
                value: notifier.totalCount.toString(),
                icon: Icons.calendar_month_rounded,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppointmentStatsCard(
                title: 'Pending',
                value: notifier.pendingCount.toString(),
                icon: Icons.pending_actions_rounded,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: AppointmentStatsCard(
                title: 'Confirmed',
                value: notifier.confirmedCount.toString(),
                icon: Icons.check_circle_outline_rounded,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppointmentStatsCard(
                title: 'Completed',
                value: notifier.completedCount.toString(),
                icon: Icons.task_alt_rounded,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AppointmentStatsCard(
          title: 'Paid Revenue',
          value:
              'PKR ${notifier.totalRevenue.toStringAsFixed(0)}',
          icon: Icons.payments_rounded,
          color: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter(
    BuildContext context,
    AdminAppointmentsNotifier notifier,
  ) {
    final hasFilters = notifier.selectedStatus != null ||
        notifier.selectedAppointmentType != null ||
        notifier.selectedPaymentStatus != null;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: notifier.search,
                decoration: InputDecoration(
                  hintText: 'Search appointments...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          tooltip: 'Clear search',
                          onPressed: () {
                            _searchController.clear();
                            notifier.search('');
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.clear_rounded,
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              tooltip: 'Filters',
              onPressed: () {
                AppointmentFilterSheet.show(
                  context: context,
                  selectedStatus: notifier.selectedStatus,
                  selectedAppointmentType:
                      notifier.selectedAppointmentType,
                  selectedPaymentStatus:
                      notifier.selectedPaymentStatus,
                  onStatusChanged: notifier.filterByStatus,
                  onAppointmentTypeChanged:
                      notifier.filterByAppointmentType,
                  onPaymentStatusChanged:
                      notifier.filterByPaymentStatus,
                  onClear: notifier.clearFilters,
                );
              },
              style: IconButton.styleFrom(
                backgroundColor: hasFilters
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                foregroundColor: hasFilters
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
              icon: const Icon(Icons.tune_rounded),
            ),
          ],
        ),
        if (hasFilters) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: notifier.clearFilters,
              icon: const Icon(Icons.clear_all_rounded),
              label: const Text('Clear filters'),
            ),
          ),
        ],
      ],
    );
  }
}

class _EmptyAppointmentsView extends StatelessWidget {
  const _EmptyAppointmentsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No appointments found',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 56,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 12),
            const Text(
              'Unable to load appointments',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
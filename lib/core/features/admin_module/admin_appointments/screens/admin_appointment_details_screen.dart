import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_appointments/models/admin_appointment_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/models/appointment_status_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/providers/admin_appointments_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/widgets/appointment_status_chip.dart';

class AdminAppointmentDetailsScreen extends ConsumerWidget {
  final String appointmentId;

  const AdminAppointmentDetailsScreen({
    super.key,
    required this.appointmentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsState = ref.watch(adminAppointmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: appointmentsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Unable to load appointment details.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        data: (appointments) {
          AdminAppointmentModel? appointment;

          for (final item in appointments) {
            if (item.id == appointmentId) {
              appointment = item;
              break;
            }
          }

          appointment ??= _findFromAllAppointments(ref);

          if (appointment == null) {
            return const _AppointmentNotFoundView();
          }

          return _AppointmentDetailsContent(
            appointment: appointment,
            onStatusChanged: (status) {
              ref
                  .read(adminAppointmentsProvider.notifier)
                  .updateStatus(
                    appointment!.id,
                    status,
                  );
            },
          );
        },
      ),
    );
  }

  AdminAppointmentModel? _findFromAllAppointments(WidgetRef ref) {
    final notifier = ref.read(adminAppointmentsProvider.notifier);

    for (final appointment in notifier.filteredAppointments) {
      if (appointment.id == appointmentId) {
        return appointment;
      }
    }

    return null;
  }
}

class _AppointmentDetailsContent extends StatelessWidget {
  final AdminAppointmentModel appointment;
  final ValueChanged<String> onStatusChanged;

  const _AppointmentDetailsContent({
    required this.appointment,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AppointmentHeader(
          appointment: appointment,
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Appointment Information',
          icon: Icons.calendar_month_outlined,
          children: [
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              label: 'Date',
              value: _formatDate(appointment.appointmentDate),
            ),
            _DetailRow(
              icon: Icons.access_time_outlined,
              label: 'Time',
              value: appointment.appointmentTime,
            ),
            _DetailRow(
              icon: Icons.video_call_outlined,
              label: 'Appointment Type',
              value: appointment.appointmentType,
            ),
            _DetailRow(
              icon: Icons.payments_outlined,
              label: 'Fee',
              value: 'PKR ${appointment.fee.toStringAsFixed(0)}',
            ),
            _DetailRow(
              icon: Icons.payment_outlined,
              label: 'Payment Status',
              value: appointment.paymentStatus,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Client Information',
          icon: Icons.person_outline_rounded,
          children: [
            _DetailRow(
              icon: Icons.person_outline,
              label: 'Name',
              value: appointment.clientName,
            ),
            _DetailRow(
              icon: Icons.badge_outlined,
              label: 'Client ID',
              value: appointment.clientId,
            ),
            _DetailRow(
              icon: Icons.email_outlined,
              label: 'Email',
              value: appointment.clientEmail,
            ),
            _DetailRow(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: appointment.clientPhone,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Lawyer Information',
          icon: Icons.gavel_outlined,
          children: [
            _DetailRow(
              icon: Icons.person_outline,
              label: 'Name',
              value: appointment.lawyerName,
            ),
            _DetailRow(
              icon: Icons.badge_outlined,
              label: 'Lawyer ID',
              value: appointment.lawyerId,
            ),
            _DetailRow(
              icon: Icons.work_outline,
              label: 'Specialization',
              value: appointment.lawyerSpecialization,
            ),
          ],
        ),
        if (appointment.caseId != null ||
            appointment.caseTitle != null) ...[
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Case Information',
            icon: Icons.folder_outlined,
            children: [
              if (appointment.caseId != null)
                _DetailRow(
                  icon: Icons.folder_outlined,
                  label: 'Case ID',
                  value: appointment.caseId!,
                ),
              if (appointment.caseTitle != null)
                _DetailRow(
                  icon: Icons.description_outlined,
                  label: 'Case',
                  value: appointment.caseTitle!,
                ),
            ],
          ),
        ],
        if (appointment.notes != null &&
            appointment.notes!.trim().isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Notes',
            icon: Icons.notes_outlined,
            children: [
              Text(
                appointment.notes!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
        const SizedBox(height: 20),
        _StatusActions(
          appointment: appointment,
          onStatusChanged: onStatusChanged,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  static String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _AppointmentHeader extends StatelessWidget {
  final AdminAppointmentModel appointment;

  const _AppointmentHeader({
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final initials = appointment.clientName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withValues(
                        alpha: 0.10,
                      ),
              child: Text(
                initials.isEmpty ? '?' : initials,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.clientName,
                    style:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'with ${appointment.lawyerName}',
                    style:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                  ),
                  const SizedBox(height: 10),
                  AppointmentStatusChip(
                    status: appointment.status,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusActions extends StatelessWidget {
  final AdminAppointmentModel appointment;
  final ValueChanged<String> onStatusChanged;

  const _StatusActions({
    required this.appointment,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final status = appointment.status;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Status',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        if (status == AppointmentStatusModel.pending.value)
          _ActionButton(
            label: 'Confirm Appointment',
            icon: Icons.check_circle_outline_rounded,
            onPressed: () {
              onStatusChanged(
                AppointmentStatusModel.confirmed.value,
              );
            },
          ),
        if (status == AppointmentStatusModel.confirmed.value)
          _ActionButton(
            label: 'Mark as Completed',
            icon: Icons.task_alt_rounded,
            onPressed: () {
              onStatusChanged(
                AppointmentStatusModel.completed.value,
              );
            },
          ),
        if (status != AppointmentStatusModel.cancelled.value &&
            status != AppointmentStatusModel.completed.value &&
            status != AppointmentStatusModel.noShow.value)
          _ActionButton(
            label: 'Cancel Appointment',
            icon: Icons.cancel_outlined,
            outlined: true,
            onPressed: () {
              onStatusChanged(
                AppointmentStatusModel.cancelled.value,
              );
            },
          ),
        if (status == AppointmentStatusModel.completed.value ||
            status == AppointmentStatusModel.cancelled.value ||
            status == AppointmentStatusModel.noShow.value)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'This appointment is ${AppointmentStatusModel.fromValue(status).label.toLowerCase()} and no further status actions are available.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
            ),
          ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool outlined;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentNotFoundView extends StatelessWidget {
  const _AppointmentNotFoundView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_busy_rounded,
              size: 60,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 14),
            Text(
              'Appointment not found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'The requested appointment could not be found.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
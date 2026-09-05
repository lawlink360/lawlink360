import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_appointments/models/admin_appointment_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/widgets/appointment_status_chip.dart';

class AdminAppointmentCard extends StatelessWidget {
  final AdminAppointmentModel appointment;
  final VoidCallback? onTap;
  final VoidCallback? onConfirm;
  final VoidCallback? onComplete;
  final VoidCallback? onCancel;

  const AdminAppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onConfirm,
    this.onComplete,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Avatar(
                    name: appointment.clientName,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.clientName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'with ${appointment.lawyerName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  AppointmentStatusChip(
                    status: appointment.status,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _InfoRow(
                icon: Icons.calendar_today_rounded,
                text: _formatDate(appointment.appointmentDate),
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.access_time_rounded,
                text: appointment.appointmentTime,
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: _appointmentTypeIcon(appointment.appointmentType),
                text: appointment.appointmentType,
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.payments_outlined,
                text:
                    'PKR ${appointment.fee.toStringAsFixed(0)} • ${appointment.paymentStatus}',
              ),
              if (appointment.caseTitle != null) ...[
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.folder_outlined,
                  text: appointment.caseTitle!,
                ),
              ],
              if (onConfirm != null ||
                  onComplete != null ||
                  onCancel != null) ...[
                const SizedBox(height: 14),
                const Divider(height: 1),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (onConfirm != null)
                      OutlinedButton.icon(
                        onPressed: onConfirm,
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                        ),
                        label: const Text('Confirm'),
                      ),
                    if (onComplete != null)
                      OutlinedButton.icon(
                        onPressed: onComplete,
                        icon: const Icon(
                          Icons.task_alt,
                          size: 18,
                        ),
                        label: const Text('Complete'),
                      ),
                    if (onCancel != null)
                      OutlinedButton.icon(
                        onPressed: onCancel,
                        icon: const Icon(
                          Icons.cancel_outlined,
                          size: 18,
                        ),
                        label: const Text('Cancel'),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static IconData _appointmentTypeIcon(String type) {
    final normalizedType = type.toLowerCase();

    if (normalizedType.contains('video')) {
      return Icons.videocam_outlined;
    }

    if (normalizedType.contains('phone')) {
      return Icons.phone_outlined;
    }

    return Icons.location_on_outlined;
  }

  static String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _Avatar extends StatelessWidget {
  final String name;

  const _Avatar({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return CircleAvatar(
      radius: 24,
      backgroundColor: Theme.of(context).colorScheme.primary.withValues(
            alpha: 0.10,
          ),
      child: Text(
        initials.isEmpty ? '?' : initials,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
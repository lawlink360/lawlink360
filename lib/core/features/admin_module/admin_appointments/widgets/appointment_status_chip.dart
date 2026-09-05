import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_appointments/models/appointment_status_model.dart';

class AppointmentStatusChip extends StatelessWidget {
  final String status;

  const AppointmentStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusModel = AppointmentStatusModel.fromValue(status);

    IconData icon;
    Color color;

    if (statusModel.isConfirmed) {
      icon = Icons.check_circle_rounded;
      color = Colors.green;
    } else if (statusModel.isCompleted) {
      icon = Icons.task_alt_rounded;
      color = Colors.teal;
    } else if (statusModel.isCancelled) {
      icon = Icons.cancel_rounded;
      color = Colors.red;
    } else if (statusModel.isNoShow) {
      icon = Icons.person_off_rounded;
      color = Colors.deepOrange;
    } else {
      icon = Icons.pending_actions_rounded;
      color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            statusModel.label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
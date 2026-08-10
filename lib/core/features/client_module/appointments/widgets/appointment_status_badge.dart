import 'package:flutter/material.dart';

import '../models/appointment_status.dart';

class AppointmentStatusBadge extends StatelessWidget {
  final AppointmentStatus status;

  const AppointmentStatusBadge({
    super.key,
    required this.status,
  });

  Color get backgroundColor {
    switch (status) {
      case AppointmentStatus.today:
        return Colors.red.shade100;
      case AppointmentStatus.upcoming:
        return Colors.green.shade100;
      case AppointmentStatus.completed:
        return Colors.blue.shade100;
      case AppointmentStatus.cancelled:
        return Colors.grey.shade300;
    }
  }

  Color get textColor {
    switch (status) {
      case AppointmentStatus.today:
        return Colors.red.shade800;
      case AppointmentStatus.upcoming:
        return Colors.green.shade800;
      case AppointmentStatus.completed:
        return Colors.blue.shade800;
      case AppointmentStatus.cancelled:
        return Colors.grey.shade800;
    }
  }

  String get label {
    switch (status) {
      case AppointmentStatus.today:
        return "Today";
      case AppointmentStatus.upcoming:
        return "Upcoming";
      case AppointmentStatus.completed:
        return "Completed";
      case AppointmentStatus.cancelled:
        return "Cancelled";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../models/appointment_model.dart';
import 'appointment_status_badge.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      appointment.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  AppointmentStatusBadge(
                    status: appointment.status,
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                "Appointment ID: ${appointment.appointmentId}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 18),

              _infoRow(
                Icons.gavel_outlined,
                "Lawyer",
                appointment.lawyerName,
              ),

              const SizedBox(height: 10),

              _infoRow(
                Icons.location_on_outlined,
                "Location",
                appointment.location,
              ),

              const Divider(height: 30),

              Row(
                children: [
                  Expanded(
                    child: _bottomInfo(
                      Icons.calendar_today_outlined,
                      "Date",
                      "${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year}",
                    ),
                  ),

                  Expanded(
                    child: _bottomInfo(
                      Icons.access_time_outlined,
                      "Time",
                      "${appointment.dateTime.hour.toString().padLeft(2, '0')}:${appointment.dateTime.minute.toString().padLeft(2, '0')}",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF0F172A),
        ),

        const SizedBox(width: 8),

        Text(
          "$title: ",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  Widget _bottomInfo(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 18,
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
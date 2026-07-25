import 'package:flutter/material.dart';

class AppointmentDetailsCard extends StatelessWidget {
  const AppointmentDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Appointment Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 20),
          _detailRow(
            Icons.person,
            "Lawyer",
            "Adv. Ahmed Khan",
          ),
          _detailRow(
            Icons.calendar_today,
            "Date",
            "20 July 2026",
          ),
          _detailRow(
            Icons.access_time,
            "Time",
            "11:00 AM",
          ),
          _detailRow(
            Icons.video_call,
            "Consultation",
            "Video Call",
          ),
          _detailRow(
            Icons.confirmation_number,
            "Booking ID",
            "#LL360-20260001",
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
        ],
      ),
    );
  }
}
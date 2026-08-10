import 'package:flutter/material.dart';

class UpcomingAppointmentsCard extends StatelessWidget {
  const UpcomingAppointmentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.calendar_month,
            color: Colors.orange,
            size: 34,
          ),

          SizedBox(width: 14),

          Expanded(
            child: Text(
              "No upcoming appointments.",
            ),
          ),
        ],
      ),
    );
  }
}
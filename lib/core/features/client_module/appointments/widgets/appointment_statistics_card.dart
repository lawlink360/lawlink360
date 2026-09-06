import 'package:flutter/material.dart';

class AppointmentStatisticsCards extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const AppointmentStatisticsCards({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha:.12),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
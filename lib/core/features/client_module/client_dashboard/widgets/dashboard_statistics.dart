import 'package:flutter/material.dart';

class DashboardStatistics extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String value;

  const DashboardStatistics({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
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
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
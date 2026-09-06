import 'package:flutter/material.dart';

class ProfileStatsCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String title;
  final VoidCallback? onTap;

  const ProfileStatsCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: iconColor.withValues(alpha:.12),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
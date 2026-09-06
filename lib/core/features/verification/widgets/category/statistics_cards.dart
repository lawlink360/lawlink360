import 'package:flutter/material.dart';

class StatisticsCards extends StatelessWidget {
  const StatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            StatisticCard(
              title: 'Services',
              value: '85+',
              icon: Icons.verified_user_rounded,
              color: Color(0xFF2563EB),
            ),
            SizedBox(width: 12),
            StatisticCard(
              title: 'Categories',
              value: '8',
              icon: Icons.dashboard_customize_rounded,
              color: Color(0xFFF59E0B),
            ),
            SizedBox(width: 12),
            StatisticCard(
              title: 'Recent',
              value: '0',
              icon: Icons.history_rounded,
              color: Color(0xFF10B981),
            ),
            SizedBox(width: 12),
            StatisticCard(
              title: 'Saved',
              value: '0',
              icon: Icons.bookmark_rounded,
              color: Color(0xFF8B5CF6),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 105,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withValues(alpha:0.12),
              child: Icon(
                icon,
                color: color,
                size: 18,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
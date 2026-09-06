import 'package:flutter/material.dart';

class LawyerClientActivityCard extends StatelessWidget {
  const LawyerClientActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Client Activity',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 16),

          _ActivityItem(
            icon: Icons.description_outlined,
            title: 'New document uploaded',
            clientName: 'Muhammad Ahmed',
            time: '15 min ago',
          ),

          const Divider(height: 24),

          _ActivityItem(
            icon: Icons.calendar_month_outlined,
            title: 'Appointment confirmed',
            clientName: 'Ayesha Khan',
            time: '1 hour ago',
          ),

          const Divider(height: 24),

          _ActivityItem(
            icon: Icons.message_outlined,
            title: 'New message received',
            clientName: 'Ali Raza',
            time: '3 hours ago',
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String clientName;
  final String time;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.clientName,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFD4AF37), size: 21),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                clientName,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),

              const SizedBox(height: 4),

              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 10.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DashboardCaseOverview extends StatelessWidget {
  const DashboardCaseOverview({super.key});

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
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          _CaseStatusRow(
            icon: Icons.folder_open_outlined,
            title: 'Active Cases',
            value: '17',
          ),

          Divider(height: 24),

          _CaseStatusRow(
            icon: Icons.pending_actions_outlined,
            title: 'Pending Cases',
            value: '06',
          ),

          Divider(height: 24),

          _CaseStatusRow(
            icon: Icons.check_circle_outline,
            title: 'Completed Cases',
            value: '31',
          ),
        ],
      ),
    );
  }
}

class _CaseStatusRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _CaseStatusRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0xFFFFF8E1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 22,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF13294B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
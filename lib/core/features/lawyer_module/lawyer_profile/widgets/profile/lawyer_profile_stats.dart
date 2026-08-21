import 'package:flutter/material.dart';

class LawyerProfileStats extends StatelessWidget {
  const LawyerProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: _StatItem(
              icon: Icons.business_center_outlined,
              title: 'Total Cases',
              value: '156',
            ),
          ),

          _VerticalDivider(),

          Expanded(
            child: _StatItem(
              icon: Icons.people_outline,
              title: 'Consultations',
              value: '342',
            ),
          ),

          _VerticalDivider(),

          Expanded(
            child: _StatItem(
              icon: Icons.star_border_rounded,
              title: 'Success Rate',
              value: '92%',
            ),
          ),

          _VerticalDivider(),

          Expanded(
            child: _StatItem(
              icon: Icons.workspace_premium_outlined,
              title: 'Member Since',
              value: 'May 2021',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF2563EB),
          size: 28,
        ),

        const SizedBox(height: 8),

        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF475569),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF0F1B35),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 1,
      color: const Color(0xFFE2E8F0),
    );
  }
}
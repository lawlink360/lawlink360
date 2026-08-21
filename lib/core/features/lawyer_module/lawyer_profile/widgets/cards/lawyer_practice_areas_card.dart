import 'package:flutter/material.dart';

class LawyerPracticeAreasCard extends StatelessWidget {
  const LawyerPracticeAreasCard({super.key});

  @override
  Widget build(BuildContext context) {
    const practiceAreas = [
      _PracticeArea(
        title: 'Criminal Law',
        icon: Icons.balance_outlined,
      ),
      _PracticeArea(
        title: 'Bail Matters',
        icon: Icons.gavel_outlined,
      ),
      _PracticeArea(
        title: 'Constitutional Law',
        icon: Icons.account_balance_outlined,
      ),
      _PracticeArea(
        title: 'Civil Litigation',
        icon: Icons.description_outlined,
      ),
      _PracticeArea(
        title: 'Family Law',
        icon: Icons.people_outline,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Practice Areas',
            style: TextStyle(
              color: Color(0xFF0F1B35),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: practiceAreas.map((area) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      area.icon,
                      size: 20,
                      color: const Color(0xFF2563EB),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      area.title,
                      style: const TextStyle(
                        color: Color(0xFF2563EB),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PracticeArea {
  final String title;
  final IconData icon;

  const _PracticeArea({
    required this.title,
    required this.icon,
  });
}
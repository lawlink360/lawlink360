import 'package:flutter/material.dart';

class LawyerPracticeAreasCard extends StatelessWidget {
  final List<String> practiceAreas;

  const LawyerPracticeAreasCard({
    super.key,
    required this.practiceAreas,
  });

  @override
  Widget build(BuildContext context) {
    if (practiceAreas.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Practice Areas',
              style: TextStyle(
                color: Color(0xFF0F1B35),
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'No practice areas selected yet.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

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
                    const Icon(
                      Icons.balance_outlined,
                      size: 20,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      area,
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

import 'package:flutter/material.dart';

class LawyerPracticeAreasCard extends StatelessWidget {
  const LawyerPracticeAreasCard({super.key});

  @override
  Widget build(BuildContext context) {
    final areas = [
      "Criminal Law",
      "Civil Law",
      "Family Law",
      "Corporate Law",
      "Property Law",
      "Cyber Crime",
      "Tax Law",
      "Consumer Protection",
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Practice Areas",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: areas.map((area) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withOpacity(.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  area,
                  style: const TextStyle(
                    color: Color(0xFF0D1B2A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
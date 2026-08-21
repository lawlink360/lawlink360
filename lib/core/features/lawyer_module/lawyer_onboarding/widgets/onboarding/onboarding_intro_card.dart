import 'package:flutter/material.dart';

class OnboardingIntroCard extends StatelessWidget {
  const OnboardingIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: Color(0xFFF8F1D8),
            child: Icon(
              Icons.person_outline,
              size: 42,
              color: Color(0xFFD4AF37),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Create Your Professional Identity',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Your profile will help clients understand your expertise, experience, practice areas, and consultation services.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
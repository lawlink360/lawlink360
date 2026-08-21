import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Build Your Lawyer Profile',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1B2A),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Create a professional profile that helps clients discover and connect with you.',
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
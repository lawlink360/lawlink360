import 'package:flutter/material.dart';

class LawyerClientsHeader extends StatelessWidget {
  const LawyerClientsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage Your Clients',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF13294B),
          ),
        ),

        SizedBox(height: 8),

        Text(
          'View your clients, manage requests, track cases, and stay connected with the people you represent.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
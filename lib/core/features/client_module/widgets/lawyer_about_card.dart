import 'package:flutter/material.dart';

class LawyerAboutCard extends StatelessWidget {
  const LawyerAboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About Lawyer",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          SizedBox(height: 14),
          Text(
            "Adv. Ahmed Khan is a highly experienced Criminal and Civil Lawyer with over 12 years of professional practice. He has successfully represented hundreds of clients before District Courts, High Courts and Special Tribunals. His approach focuses on professionalism, transparency and achieving practical legal solutions for clients.",
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
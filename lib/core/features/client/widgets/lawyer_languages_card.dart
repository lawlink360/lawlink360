import 'package:flutter/material.dart';

class LawyerLanguagesCard extends StatelessWidget {
  const LawyerLanguagesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      "English",
      "Urdu",
      "Punjabi",
      "Hindi",
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Languages",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: languages.map((e) {
              return Chip(
                backgroundColor: const Color(0xFFD4AF37).withOpacity(.15),
                label: Text(e),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
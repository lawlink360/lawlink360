import 'package:flutter/material.dart';

class LawyerPracticeChip extends StatelessWidget {
  const LawyerPracticeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
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
            children: const [

              _Chip("Criminal Law"),
              _Chip("Bail Matters"),
              _Chip("FIR & Quash"),
              _Chip("Cyber Crime"),
              _Chip("White Collar"),
              _Chip("Appeals"),
              _Chip("Constitutional"),
              _Chip("Family Law"),

            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String title;

  const _Chip(this.title);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(
        Icons.gavel,
        size: 18,
        color: Color(0xFFD4AF37),
      ),
      label: Text(title),
      backgroundColor: const Color(0xFFF8F8F8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(
          color: Color(0xFFD4AF37),
        ),
      ),
    );
  }
}
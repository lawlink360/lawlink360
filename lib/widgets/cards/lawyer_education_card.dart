import 'package:flutter/material.dart';

class LawyerEducationCard extends StatelessWidget {
  const LawyerEducationCard({super.key});

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
            "Education & Certifications",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 20),

          _item(
            Icons.school,
            "LL.B",
            "University of Punjab",
          ),

          const Divider(height: 30),

          _item(
            Icons.workspace_premium,
            "LL.M (Criminal Law)",
            "International Islamic University",
          ),

          const Divider(height: 30),

          _item(
            Icons.verified,
            "Pakistan Bar Council",
            "Licensed Advocate",
          ),
        ],
      ),
    );
  }

  static Widget _item(
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Row(
      children: [

        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withValues(alpha:.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFD4AF37),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
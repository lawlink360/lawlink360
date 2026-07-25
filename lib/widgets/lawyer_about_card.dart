import 'package:flutter/material.dart';

class AboutLawyerCard extends StatelessWidget {
  const AboutLawyerCard({super.key});

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
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "About Lawyer",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Adv. Ahmed Khan is a highly experienced Criminal Lawyer with over 10 years of professional practice. He specializes in criminal trials, bail matters, FIRs, white-collar crimes, appeals and constitutional petitions. His dedication, integrity and successful case history have earned the trust of hundreds of clients across Pakistan.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 14),

          _infoRow(
            Icons.badge_outlined,
            "Pakistan Bar Council",
          ),

          const SizedBox(height: 12),

          _infoRow(
            Icons.location_on_outlined,
            "Islamabad High Court",
          ),

          const SizedBox(height: 12),

          _infoRow(
            Icons.schedule_outlined,
            "Mon - Sat • 9:00 AM - 7:00 PM",
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [

        Icon(
          icon,
          color: Color(0xFFD4AF37),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
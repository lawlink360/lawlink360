import 'package:flutter/material.dart';
import 'case_card.dart';

class MyCasesSection extends StatelessWidget {
  const MyCasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Text(
                "My Cases",
                style: TextStyle(
                  fontSize: 28,
                      fontWeight: FontWeight.bold,
                       color: Color(0xFF13294B),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "View All",
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 240,
          child: ListView(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            children: [
              CaseCard(
                title: "Civil Suit No.123/2026",
                status: "Active",
                hearingDate: "18 July 2026",
                progress: 0.70,
                onTap: () {},
              ),

              CaseCard(
                title: "Family Matter",
                status: "Pending",
                hearingDate: "22 July 2026",
                progress: 0.45,
                onTap: () {},
              ),

              CaseCard(
                title: "Bail Application",
                status: "Completed",
                hearingDate: "Completed",
                progress: 1.0,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
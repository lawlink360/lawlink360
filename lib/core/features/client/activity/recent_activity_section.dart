import 'package:flutter/material.dart';
import 'activity_card.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13294B),
                ),
              ),

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

          const SizedBox(height: 18),

          const ActivityCard(
            icon: Icons.description,
            iconColor: Colors.green,
            title: "Application Generated",
            subtitle: "NADRA CNIC Application",
            time: "2 hours ago",
          ),

          const ActivityCard(
            icon: Icons.video_call,
            iconColor: Colors.blue,
            title: "Lawyer Consultation",
            subtitle: "Video Call with Adv. Ahmed Khan",
            time: "Yesterday",
          ),

          const ActivityCard(
            icon: Icons.gavel,
            iconColor: Colors.deepPurple,
            title: "Case Updated",
            subtitle: "Civil Suit No.123/2026",
            time: "2 days ago",
          ),

          const ActivityCard(
            icon: Icons.verified_user,
            iconColor: Colors.orange,
            title: "Document Verified",
            subtitle: "Sale Agreement Verification",
            time: "3 days ago",
          ),
        ],
      ),
    );
  }
}

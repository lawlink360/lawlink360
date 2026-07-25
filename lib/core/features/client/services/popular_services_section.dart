import 'package:flutter/material.dart';
import 'service_card.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Popular Services",
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

          const SizedBox(height: 18),

          ServiceCard(
            icon: Icons.badge_outlined,
            title: "NADRA Services",
            subtitle: "CNIC, FRC & Family Records",
            onTap: () {},
          ),

          const SizedBox(height: 12),

          ServiceCard(
            icon: Icons.local_police_outlined,
            title: "Police Applications",
            subtitle: "FIR & Police Verification",
            onTap: () {},
          ),

          const SizedBox(height: 12),

          ServiceCard(
            icon: Icons.description_outlined,
            title: "Revenue Applications",
            subtitle: "Land & Property Records",
            onTap: () {},
          ),

          const SizedBox(height: 12),

          ServiceCard(
            icon: Icons.balance,
            title: "Consumer Court",
            subtitle: "Consumer Complaints",
            onTap: () {},
          ),

          const SizedBox(height: 12),

          ServiceCard(
            icon: Icons.flash_on,
            title: "WAPDA Complaints",
            subtitle: "Electricity Complaints",
            onTap: () {},
          ),

          const SizedBox(height: 12),

          ServiceCard(
            icon: Icons.account_balance,
            title: "PM Portal",
            subtitle: "Government Complaints",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
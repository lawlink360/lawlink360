import 'package:flutter/material.dart';

import '../data/profile_menu_data.dart';
import '../data/profile_stats_data.dart';

import '../widgets/logout_button.dart';
import '../widgets/premium_banner.dart';
import '../widgets/profile_header_card.dart';
import '../widgets/profile_menu_tile.dart';
import '../widgets/profile_stats_card.dart';
import '../data/profile_user_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        children: [
          const SizedBox(height: 16),

          ProfileHeaderCard(
            name: ProfileUserData.currentUser.name,
            email: ProfileUserData.currentUser.email,
            phone: ProfileUserData.currentUser.phone,
            imageUrl: ProfileUserData.currentUser.imageUrl,
            verified: ProfileUserData.currentUser.verified,
          ),

          const SizedBox(height: 20),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: ProfileStatsData.items
                  .map(
                    (stat) => ProfileStatsCard(
                      icon: stat.icon,
                      iconColor: stat.iconColor,
                      value: stat.value,
                      title: stat.title,
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 20),

          PremiumBanner(onUpgrade: () {}),

          const SizedBox(height: 20),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: ProfileMenuData.items
                  .map(
                    (item) => ProfileMenuTile(
                      icon: item.icon,
                      iconColor: item.iconColor,
                      title: item.title,
                      subtitle: item.subtitle,
                      onTap: item.onTap,
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 20),

          LogoutButton(onPressed: () {}),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

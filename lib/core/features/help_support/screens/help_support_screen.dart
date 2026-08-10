import 'package:flutter/material.dart';

import '../data/faq_data.dart';
import '../data/help_data.dart';
import '../widgets/contact_card.dart';
import '../widgets/emergency_support_banner.dart';
import '../widgets/faq_tile.dart';
import '../widgets/help_category_card.dart';
import '../widgets/social_links_card.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Help & Support"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          TextField(
            decoration: InputDecoration(
              hintText: "Search Help",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Help Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...HelpData.categories.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: HelpCategoryCard(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...FaqData.items.map(
            (faq) => FaqTile(
              question: faq.question,
              answer: faq.answer,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Contact Support",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: const [
                ContactCard(
                  icon: Icons.email_outlined,
                  iconColor: Colors.blue,
                  title: "Email",
                  subtitle: "support@lawlink360.com",
                ),
                Divider(height: 1),
                ContactCard(
                  icon: Icons.phone_outlined,
                  iconColor: Colors.green,
                  title: "Phone",
                  subtitle: "+92 XXX XXXXXXX",
                ),
                Divider(height: 1),
                ContactCard(
                  icon: Icons.chat_outlined,
                  iconColor: Colors.orange,
                  title: "Live Chat",
                  subtitle: "Available soon",
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Follow Us",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const SocialLinksCard(
            title: "Facebook",
            icon: Icons.facebook,
            color: Colors.blue,
          ),

          const SocialLinksCard(
            title: "Instagram",
            icon: Icons.camera_alt_outlined,
            color: Colors.purple,
          ),

          const SocialLinksCard(
            title: "LinkedIn",
            icon: Icons.business,
            color: Colors.indigo,
          ),

          const SocialLinksCard(
            title: "YouTube",
            icon: Icons.play_circle_outline,
            color: Colors.red,
          ),

          const SizedBox(height: 20),

          const EmergencySupportBanner(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
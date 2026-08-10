import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/data/lawyer_faq_data.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/data/lawyer_help_data.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/widgets/lawyer_contact_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/widgets/lawyer_emergency_support_banner.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/widgets/lawyer_faq_tile.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/widgets/lawyer_help_category_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/widgets/lawyer_social_links_card.dart';

class LawyerHelpSupportScreen extends StatelessWidget {
  const LawyerHelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Color(0xFF13294B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Help',
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF13294B),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Help Categories
          const Text(
            'Help Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 12),

          ...LawyerHelpData.categories.map(
            (item) => HelpCategoryCard(
              icon: item.icon,
              iconColor: item.iconColor,
              title: item.title,
              subtitle: item.subtitle,
            ),
          ),

          const SizedBox(height: 14),

          // FAQs
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 12),

          ...LawyerFaqData.items.map(
            (faq) => FaqTile(
              question: faq.question,
              answer: faq.answer,
            ),
          ),

          const SizedBox(height: 14),

          // Contact Support
          const Text(
            'Contact Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                ContactCard(
                  icon: Icons.email_outlined,
                  iconColor: Colors.blue,
                  title: 'Email',
                  subtitle: 'support@lawlink360.com',
                ),
                Divider(height: 1),
                ContactCard(
                  icon: Icons.phone_outlined,
                  iconColor: Colors.green,
                  title: 'Phone',
                  subtitle: '+92 XXX XXXXXXX',
                ),
                Divider(height: 1),
                ContactCard(
                  icon: Icons.chat_outlined,
                  iconColor: Colors.orange,
                  title: 'Live Chat',
                  subtitle: 'Available soon',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Social Media
          const Text(
            'Follow Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 12),

          SocialLinksCard(
            title: 'Facebook',
            icon: Icons.facebook,
            color: Colors.blue,
            onTap: () {},
          ),

          SocialLinksCard(
            title: 'Instagram',
            icon: Icons.camera_alt_outlined,
            color: Colors.purple,
            onTap: () {},
          ),

          SocialLinksCard(
            title: 'LinkedIn',
            icon: Icons.business,
            color: Colors.indigo,
            onTap: () {},
          ),

          SocialLinksCard(
            title: 'YouTube',
            icon: Icons.play_circle_outline,
            color: Colors.red,
            onTap: () {},
          ),

          const SizedBox(height: 10),

          // Support Banner
          const EmergencySupportBanner(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
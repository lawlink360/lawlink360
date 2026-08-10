import 'package:flutter/material.dart';

import 'package:lawlink360/widgets/cards/home_header.dart';
import 'package:lawlink360/widgets/appbar/ai_search_bar.dart';
import 'package:lawlink360/core/features/lawyer_module/widgets/lawyer_app_drawer.dart';
import '../widgets/lawyer_quick_actions.dart';

class LawyerHomeScreen extends StatelessWidget {
  const LawyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      drawer: const LawyerAppDrawer(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeader(
                greeting: 'Good Morning 👋',
                name: 'Adv. Lawyer',
                subtitle: 'Your Professional Legal Workspace',
              ),

              Transform.translate(
                offset: const Offset(0, -30),
                child: const AISearchBar(),
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF13294B),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const LawyerQuickActions(),

              const SizedBox(height: 28),

              const _LawyerUpdatesSection(),

              const SizedBox(height: 40),

              const Center(
                child: Column(
                  children: [
                    Text(
                      'LawLink360',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13294B),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Your Professional Legal Platform',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Version 1.0.0 • © 2026 LawLink360',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LawyerUpdatesSection extends StatelessWidget {
  const _LawyerUpdatesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Updates',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 18),

          _UpdateCard(
            icon: Icons.menu_book_rounded,
            title: 'New Law',
            description:
                'New legislation and legal amendments are now available.',
          ),

          const SizedBox(height: 12),

          _UpdateCard(
            icon: Icons.gavel_rounded,
            title: 'New Judgment',
            description:
                'A new important judgment has been added to LawLink360.',
          ),

          const SizedBox(height: 12),

          _UpdateCard(
            icon: Icons.info_outline_rounded,
            title: 'Legal Update',
            description:
                'Important legal and procedural information has been updated.',
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _UpdateCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFD4AF37),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFFD4AF37),
          ),
        ],
      ),
    );
  }
}
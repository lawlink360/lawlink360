import 'package:flutter/material.dart';
import 'package:lawlink360/widgets/bottom_nav_bar.dart';
import 'package:lawlink360/core/features/client/screens/find_lawyer_screen.dart';

import '../../../../widgets/home_header.dart';
import '../../../../widgets/ai_search_bar.dart';
import '../../../../widgets/quick_action_grid.dart';
import 'package:lawlink360/widgets/appointment/upcoming_appointment_card.dart';
import 'package:lawlink360/core/features/client/cases/my_cases_section.dart';
import 'package:lawlink360/core/features/client/services/popular_services_section.dart';
import 'package:lawlink360/core/features/client/activity/recent_activity_section.dart';
import 'package:lawlink360/core/features/client/widgets/app_drawer.dart';
import 'package:lawlink360/core/features/client/screens/chat_screen.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeader(
                greeting: "Good Morning 👋",
                name: "King Shaheer",
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
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF13294B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const QuickActionsGrid(),
              const SizedBox(height: 24),
              const UpcomingAppointmentCard(),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              const MyCasesSection(),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              const PopularServicesSection(),
              const SizedBox(height: 24),
              const SizedBox(height: 24),
              const RecentActivitySection(),
              const SizedBox(height: 40),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    Text(
                      "LawLink360",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13294B),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Your Trusted Digital Legal Partner",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Version 1.0.0 • © 2026 LawLink360",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on Dashboard
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const FindLawyerScreen(),
                ),
              );
              break;

            case 2:
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const ChatScreen(),
    ),
  );
  break;

            case 3:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Documents - Coming Soon")),
              );
              break;

            case 4:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile - Coming Soon")),
              );
              break;
          }
        },
      ),
    );
  }
}
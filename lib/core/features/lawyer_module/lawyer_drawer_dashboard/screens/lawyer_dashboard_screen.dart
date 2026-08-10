import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_drawer_dashboard/widgets/lawyer_dashboard_welcome_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_drawer_dashboard/widgets/lawyer_dashboard_stat_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_drawer_dashboard/widgets/lawyer_dashboard_schedule_card.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_drawer_dashboard/widgets/lawyer_dashboard_case_overview.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_drawer_dashboard/widgets/lawyer_dashboard_activity_card.dart';

class LawyerDashboardScreen extends StatelessWidget {
  const LawyerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xFF13294B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------
            // WELCOME
            // --------------------------------------------------

            const DashboardWelcomeCard(),

            const SizedBox(height: 26),

            // --------------------------------------------------
            // OVERVIEW
            // --------------------------------------------------

            const Text(
              'Overview',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.45,
              children: const [
                DashboardStatCard(
                  icon: Icons.people_outline,
                  title: 'Total Clients',
                  value: '24',
                ),

                DashboardStatCard(
                  icon: Icons.calendar_month_outlined,
                  title: 'Appointments',
                  value: '08',
                ),

                DashboardStatCard(
                  icon: Icons.folder_open_outlined,
                  title: 'Active Cases',
                  value: '17',
                ),

                DashboardStatCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Messages',
                  value: '05',
                ),
              ],
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // TODAY'S SCHEDULE
            // --------------------------------------------------

            const Text(
              "Today's Schedule",
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const DashboardScheduleCard(
              time: '10:00 AM',
              client: 'Muhammad Ahmed',
              matter: 'Property Consultation',
              status: 'Upcoming',
            ),

            const SizedBox(height: 12),

            const DashboardScheduleCard(
              time: '02:30 PM',
              client: 'Sara Khan',
              matter: 'Family Law Consultation',
              status: 'Upcoming',
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // CASE OVERVIEW
            // --------------------------------------------------

            const Text(
              'Case Overview',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const DashboardCaseOverview(),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // RECENT ACTIVITY
            // --------------------------------------------------

            const Text(
              'Recent Activity',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const DashboardActivityCard(
              icon: Icons.person_add_alt_1_outlined,
              title: 'New Client',
              description: 'A new client has been added.',
              time: '10 min ago',
            ),

            const SizedBox(height: 10),

            const DashboardActivityCard(
              icon: Icons.calendar_today_outlined,
              title: 'New Appointment',
              description: 'Appointment scheduled for tomorrow.',
              time: '1 hour ago',
            ),

            const SizedBox(height: 10),

            const DashboardActivityCard(
              icon: Icons.message_outlined,
              title: 'New Message',
              description: 'You have a new client message.',
              time: '2 hours ago',
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
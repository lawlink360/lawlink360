import 'package:flutter/material.dart';

import '../data/dashboard_data.dart';

import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_statistics.dart';
import '../widgets/quick_actions_card.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/recent_case_card.dart';
import '../widgets/upcoming_appointments_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = DashboardData.statistics;
    final activities = DashboardData.activities;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DashboardHeader(
            name: "LawLink User",
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              DashboardStatistics(
                icon: stats[0].icon,
                color: stats[0].color,
                title: stats[0].title,
                value: stats[0].value,
              ),

              const SizedBox(width: 12),

              DashboardStatistics(
                icon: stats[1].icon,
                color: stats[1].color,
                title: stats[1].title,
                value: stats[1].value,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              DashboardStatistics(
                icon: stats[2].icon,
                color: stats[2].color,
                title: stats[2].title,
                value: stats[2].value,
              ),

              const SizedBox(width: 12),

              DashboardStatistics(
                icon: stats[3].icon,
                color: stats[3].color,
                title: stats[3].title,
                value: stats[3].value,
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: QuickActionsCard(
                  icon: Icons.search,
                  title: "Find Lawyer",
                  onTap: () {},
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: QuickActionsCard(
                  icon: Icons.document_scanner,
                  title: "Scanner",
                  onTap: () {},
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: QuickActionsCard(
                  icon: Icons.translate,
                  title: "Translate",
                  onTap: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...activities.map(
            (activity) => RecentActivityCard(
              title: activity.title,
              subtitle: activity.subtitle,
              time: activity.time,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Upcoming Appointment",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const UpcomingAppointmentsCard(),

          const SizedBox(height: 24),

          const Text(
            "Recent Case",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const RecentCaseCard(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
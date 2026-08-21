import 'package:flutter/material.dart';

import '../widgets/digital_clerk_header.dart';
import '../widgets/daily_summary_card.dart';
import '../widgets/clerk_quick_actions.dart';
import '../widgets/today_cases_card.dart';
import '../widgets/upcoming_schedule_card.dart';
import '../widgets/pending_tasks_card.dart';
import '../widgets/fee_management_card.dart';
import '../widgets/clerk_clients_card.dart';


class DigitalClerkScreen extends StatelessWidget {
  const DigitalClerkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Digital Clerk',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          children: const [
            DigitalClerkHeader(),

            SizedBox(height: 4),

            DailySummaryCard(),

            ClerkQuickActions(),

            ClerkClientsCard(),

            TodayCasesCard(),

            UpcomingScheduleCard(),

            PendingTasksCard(),

            FeeManagementCard(),
          ],
        ),
      ),
    );
  }
}

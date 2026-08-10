import 'package:flutter/material.dart';

import '../data/appointment_data.dart';
import '../widgets/appointment_calendar_card.dart';
import '../widgets/appointment_card.dart';
import '../widgets/appointment_filter_tabs.dart';
import '../widgets/appointment_search_bar.dart';
import '../widgets/appointment_statistics_card.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Appointments"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const AppointmentCalendarCard(),

          const SizedBox(height: 20),

          const AppointmentSearchBar(),

          const SizedBox(height: 20),

          Row(
            children: const [
              AppointmentStatisticsCards(
                title: "Today",
                value: "1",
                icon: Icons.today,
                color: Colors.red,
              ),

              SizedBox(width: 10),

              AppointmentStatisticsCards(
                title: "Upcoming",
                value: "1",
                icon: Icons.schedule,
                color: Colors.green,
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: const [
              AppointmentStatisticsCards(
                title: "Completed",
                value: "1",
                icon: Icons.check_circle_outline,
                color: Colors.blue,
              ),

              SizedBox(width: 10),

              AppointmentStatisticsCards(
                title: "Cancelled",
                value: "1",
                icon: Icons.cancel_outlined,
                color: Colors.grey,
              ),
            ],
          ),

          const SizedBox(height: 24),

          AppointmentFilterTabs(
            selectedIndex: selectedTab,
            onChanged: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),

          const SizedBox(height: 20),

          ...AppointmentData.appointments.map(
            (appointment) => AppointmentCard(
              appointment: appointment,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
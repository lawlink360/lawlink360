import 'package:flutter/material.dart';

import '../models/dashboard_stats.dart';
import '../models/recent_activity.dart';

class DashboardData {
  static const List<DashboardStat> statistics = [
    DashboardStat(
      icon: Icons.gavel_outlined,
      color: Colors.deepPurple,
      title: "Cases",
      value: "0",
    ),

    DashboardStat(
      icon: Icons.calendar_today_outlined,
      color: Colors.orange,
      title: "Appointments",
      value: "0",
    ),

    DashboardStat(
      icon: Icons.description_outlined,
      color: Colors.teal,
      title: "Documents",
      value: "0",
    ),

    DashboardStat(
      icon: Icons.chat_bubble_outline,
      color: Colors.blue,
      title: "Messages",
      value: "0",
    ),
  ];

  static const List<RecentActivity> activities = [
    RecentActivity(
      title: "Welcome to LawLink360",
      subtitle: "Start by finding a lawyer.",
      time: "Today",
    ),
  ];
}
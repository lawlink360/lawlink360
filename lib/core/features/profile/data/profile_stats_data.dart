import 'package:flutter/material.dart';

import '../models/profile_stat.dart';

class ProfileStatsData {
  static const List<ProfileStat> items = [
    ProfileStat(
      icon: Icons.gavel_outlined,
      iconColor: Colors.deepPurple,
      value: "0",
      title: "My Cases",
    ),

    ProfileStat(
      icon: Icons.calendar_month_outlined,
      iconColor: Colors.orange,
      value: "0",
      title: "Appointments",
    ),

    ProfileStat(
      icon: Icons.description_outlined,
      iconColor: Colors.teal,
      value: "0",
      title: "Documents",
    ),

    ProfileStat(
      icon: Icons.bookmark_outline,
      iconColor: Colors.red,
      value: "0",
      title: "Saved Lawyers",
    ),
  ];
}
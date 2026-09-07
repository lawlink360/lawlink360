import 'package:flutter/material.dart';

import '../models/profile_menu_item.dart';

class ProfileMenuData {
  static List<ProfileMenuItem> items = [
    const ProfileMenuItem(
      title: "Personal Information",
      subtitle: "Update your personal details",
      icon: Icons.person_outline,
      iconColor: Colors.blue,
    ),

    const ProfileMenuItem(
      title: "My Cases",
      subtitle: "View all your legal cases",
      icon: Icons.gavel_outlined,
      iconColor: Colors.deepPurple,
    ),

    const ProfileMenuItem(
      title: "Appointments",
      subtitle: "Manage lawyer appointments",
      icon: Icons.calendar_month_outlined,
      iconColor: Colors.orange,
    ),

    const ProfileMenuItem(
      title: "My Documents",
      subtitle: "Generated legal documents",
      icon: Icons.description_outlined,
      iconColor: Colors.teal,
    ),

    const ProfileMenuItem(
      title: "Saved Lawyers",
      subtitle: "Your favourite lawyers",
      icon: Icons.bookmark_outline,
      iconColor: Colors.red,
    ),

    const ProfileMenuItem(
      title: "Help & Support",
      subtitle: "Need assistance?",
      icon: Icons.support_agent_outlined,
      iconColor: Colors.green,
    ),

    const ProfileMenuItem(
      title: "Settings",
      subtitle: "Application preferences",
      icon: Icons.settings_outlined,
      iconColor: Colors.grey,
    ),
  ];
}
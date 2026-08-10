import 'package:flutter/material.dart';

import '../models/settings_item.dart';

class SettingsData {
  static const List<SettingsItem> general = [
    SettingsItem(
      title: "Appearance",
      subtitle: "Light / Dark Mode",
      icon: Icons.palette_outlined,
      iconColor: Colors.deepPurple,
    ),

    SettingsItem(
      title: "Language",
      subtitle: "English",
      icon: Icons.language,
      iconColor: Colors.blue,
    ),

    SettingsItem(
      title: "Notifications",
      subtitle: "Manage alerts",
      icon: Icons.notifications_outlined,
      iconColor: Colors.orange,
      isSwitch: true,
      switchValue: true,
    ),
  ];

  static const List<SettingsItem> security = [
    SettingsItem(
      title: "Change Password",
      subtitle: "Update your password",
      icon: Icons.lock_outline,
      iconColor: Colors.red,
    ),

    SettingsItem(
      title: "Privacy",
      subtitle: "Manage your privacy",
      icon: Icons.privacy_tip_outlined,
      iconColor: Colors.green,
    ),

    SettingsItem(
      title: "Two-Factor Authentication",
      subtitle: "Extra account protection",
      icon: Icons.verified_user_outlined,
      iconColor: Colors.indigo,
      isSwitch: true,
      switchValue: false,
    ),
  ];

  static const List<SettingsItem> application = [
    SettingsItem(
      title: "Storage",
      subtitle: "Manage downloaded files",
      icon: Icons.storage_outlined,
      iconColor: Colors.teal,
    ),

    SettingsItem(
      title: "App Permissions",
      subtitle: "Camera, Storage & Microphone",
      icon: Icons.admin_panel_settings_outlined,
      iconColor: Colors.blueGrey,
    ),

    SettingsItem(
      title: "Clear Cache",
      subtitle: "Free temporary storage",
      icon: Icons.cleaning_services_outlined,
      iconColor: Colors.brown,
    ),
  ];

  static const List<SettingsItem> support = [
    SettingsItem(
      title: "Help Center",
      subtitle: "Frequently asked questions",
      icon: Icons.help_outline,
      iconColor: Colors.blue,
    ),

    SettingsItem(
      title: "Contact Support",
      subtitle: "Need assistance?",
      icon: Icons.support_agent,
      iconColor: Colors.deepOrange,
    ),

    SettingsItem(
      title: "Rate LawLink360",
      subtitle: "Share your feedback",
      icon: Icons.star_outline,
      iconColor: Colors.amber,
    ),
  ];
}
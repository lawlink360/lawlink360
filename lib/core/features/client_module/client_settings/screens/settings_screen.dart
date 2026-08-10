import 'package:flutter/material.dart';

import '../data/settings_data.dart';
import '../widgets/about_card.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';
import '../widgets/switch_setting_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        children: [

          /// General
          SettingsSection(
            title: "General",
            children: SettingsData.general.map((item) {
              if (item.isSwitch) {
                return SwitchSettingTile(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  value: item.switchValue,
                  onChanged: (_) {},
                );
              }

              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),

          /// Security
          SettingsSection(
            title: "Security",
            children: SettingsData.security.map((item) {
              if (item.isSwitch) {
                return SwitchSettingTile(
                  icon: item.icon,
                  iconColor: item.iconColor,
                  title: item.title,
                  subtitle: item.subtitle,
                  value: item.switchValue,
                  onChanged: (_) {},
                );
              }

              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),

          /// Application
          SettingsSection(
            title: "Application",
            children: SettingsData.application.map((item) {
              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),

          /// Support
          SettingsSection(
            title: "Support",
            children: SettingsData.support.map((item) {
              return SettingsTile(
                icon: item.icon,
                iconColor: item.iconColor,
                title: item.title,
                subtitle: item.subtitle,
                onTap: item.onTap,
              );
            }).toList(),
          ),

          AboutCard(
            version: "1.0.0",
            onPrivacyPolicy: () {},
            onTermsConditions: () {},
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
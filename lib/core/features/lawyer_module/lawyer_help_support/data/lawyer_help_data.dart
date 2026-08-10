import 'package:flutter/material.dart';

class LawyerHelpItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const LawyerHelpItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}

class LawyerHelpData {
  static const List<LawyerHelpItem> categories = [
    LawyerHelpItem(
      icon: Icons.person_outline,
      iconColor: Colors.blue,
      title: 'Account & Profile',
      subtitle: 'Manage your lawyer profile and account',
    ),
    LawyerHelpItem(
      icon: Icons.calendar_month_outlined,
      iconColor: Colors.green,
      title: 'Appointments',
      subtitle: 'Questions about appointments and consultations',
    ),
    LawyerHelpItem(
      icon: Icons.people_outline,
      iconColor: Colors.orange,
      title: 'Clients',
      subtitle: 'Manage and communicate with your clients',
    ),
    LawyerHelpItem(
      icon: Icons.chat_outlined,
      iconColor: Colors.purple,
      title: 'Messages',
      subtitle: 'Help with chats and client communication',
    ),
    LawyerHelpItem(
      icon: Icons.verified_outlined,
      iconColor: Colors.teal,
      title: 'Verification',
      subtitle: 'Lawyer and document verification assistance',
    ),
    LawyerHelpItem(
      icon: Icons.payments_outlined,
      iconColor: Colors.green,
      title: 'Payments & Earnings',
      subtitle: 'Payment, fees and earnings related questions',
    ),
    LawyerHelpItem(
      icon: Icons.description_outlined,
      iconColor: Colors.indigo,
      title: 'Documents & Drafting',
      subtitle: 'Help with legal documents and drafting tools',
    ),
  ];
}
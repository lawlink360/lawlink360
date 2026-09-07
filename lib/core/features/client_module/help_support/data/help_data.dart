import 'package:flutter/material.dart';

import '../models/help_category.dart';

class HelpData {
  static const List<HelpCategory> categories = [
    HelpCategory(
      title: "Getting Started",
      subtitle: "Learn how to use LawLink360",
      icon: Icons.school_outlined,
      iconColor: Colors.blue,
    ),

    HelpCategory(
      title: "Legal Services",
      subtitle: "Lawyers, cases & legal assistance",
      icon: Icons.gavel_outlined,
      iconColor: Colors.deepPurple,
    ),

    HelpCategory(
      title: "Documents",
      subtitle: "Applications & document templates",
      icon: Icons.description_outlined,
      iconColor: Colors.teal,
    ),

    HelpCategory(
      title: "Translation",
      subtitle: "Language & translation help",
      icon: Icons.translate_outlined,
      iconColor: Colors.orange,
    ),

    HelpCategory(
      title: "Account & Security",
      subtitle: "Profile, password & privacy",
      icon: Icons.security_outlined,
      iconColor: Colors.red,
    ),

    HelpCategory(
      title: "Billing & Premium",
      subtitle: "Subscriptions & payments",
      icon: Icons.workspace_premium_outlined,
      iconColor: Colors.amber,
    ),
  ];
}
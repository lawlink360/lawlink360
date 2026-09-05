import 'package:flutter/material.dart';

import '../admin_dashboard/screens/admin_dashboard_screen.dart';

/// Handles navigation within the LawLink360 Admin Module.
class AdminNavigation {
  AdminNavigation._();

  /// Opens the Admin Dashboard.
  static void openDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminDashboardScreen(),
      ),
    );
  }

  /// Opens an Admin screen using a normal Material page route.
  static void push(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  /// Replaces the current screen with an Admin screen.
  static void replace(
    BuildContext context,
    Widget screen,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  /// Returns to the previous Admin screen.
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
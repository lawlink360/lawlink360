
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_auth/screens/admin_access_denied_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_auth/screens/admin_login_screen.dart';
import 'package:lawlink360/core/features/admin_module/navigation/admin_navigation.dart';

class AdminAuthNavigation {
  AdminAuthNavigation._();

  static void openLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminLoginScreen(),
      ),
    );
  }

  static void openAccessDenied(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminAccessDeniedScreen(),
      ),
    );
  }

  static void openDashboard(BuildContext context) {
    AdminNavigation.openDashboard(context);
  }

  static void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminLoginScreen(),
      ),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/auth/providers/auth_provider.dart';
import 'package:lawlink360/auth/screens/login_screen.dart';
import 'package:lawlink360/auth/screens/role_selection_screen.dart';
import 'package:lawlink360/core/features/client_module/navigation/client_navigation_controller.dart';
import 'package:lawlink360/core/features/lawyer_module/home/navigation/lawyer_navigation_controller.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return StreamBuilder(
      stream: authRepository.authStateChanges,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Not logged in
        if (!snapshot.hasData) {
          return const LoginScreen();
        }

        final user = snapshot.data!;

        return FutureBuilder<String?>(
          future: authRepository.getUserRole(user.uid),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final role = roleSnapshot.data;

            if (role == null || role.isEmpty) {
              return const RoleSelectionScreen();
            }

            if (role == "client") {
              return const ClientNavigationController();
            }

            if (role == "lawyer") {
              return const LawyerNavigationController();
            }

            return const RoleSelectionScreen();
          },
        );
      },
    );
  }
}

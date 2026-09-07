import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/client_home_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';

class ClientNavigationController extends StatefulWidget {
  const ClientNavigationController({super.key});

  @override
  State<ClientNavigationController> createState() =>
      _ClientNavigationControllerState();
}

class _ClientNavigationControllerState
    extends State<ClientNavigationController> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    ClientDashboardScreen(),
    FindLawyerScreen(),
    VerificationScreen(),
    ApplicationHomeScreen(),
    TranslationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        height: 80,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: AppColors.accent.withValues(alpha: 0.16),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: const Icon(
              Icons.home_rounded,
              color: AppColors.accent,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.gavel_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: const Icon(
              Icons.gavel_rounded,
              color: AppColors.accent,
            ),
            label: 'Lawyer',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.verified_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: const Icon(
              Icons.verified_rounded,
              color: AppColors.accent,
            ),
            label: 'Verification',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.assignment_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: const Icon(
              Icons.assignment_rounded,
              color: AppColors.accent,
            ),
            label: 'Application',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.translate_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            selectedIcon: const Icon(
              Icons.translate_rounded,
              color: AppColors.accent,
            ),
            label: 'Translation',
          ),
        ],
      ),
    );
  }
}
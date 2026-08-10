import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/screens/client_home_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/verification/screens/verification_screen.dart';
import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/translation/screens/translation_screen.dart';

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
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.gavel_outlined),
            selectedIcon: Icon(Icons.gavel),
            label: "Lawyer",
          ),

          NavigationDestination(
            icon: Icon(Icons.verified_outlined),
            selectedIcon: Icon(Icons.verified),
            label: "Verification",
          ),

          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: "Application",
          ),

          NavigationDestination(
            icon: Icon(Icons.translate_outlined),
            selectedIcon: Icon(Icons.translate),
            label: "Translation",
          ),
        ],
      ),
    );
  }
}
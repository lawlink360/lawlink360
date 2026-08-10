import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/lawyer_module/home/screens/lawyer_home_screen.dart';
import 'package:lawlink360/core/features/verification/screens/verification_screen.dart';

class LawyerNavigationController extends StatefulWidget {
  const LawyerNavigationController({super.key});

  @override
  State<LawyerNavigationController> createState() =>
      _LawyerNavigationControllerState();
}

class _LawyerNavigationControllerState
    extends State<LawyerNavigationController> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),

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
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Clients',
          ),

          NavigationDestination(
            icon: Icon(Icons.edit_document),
            selectedIcon: Icon(Icons.edit_document),
            label: 'Drafting',
          ),

          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Laws',
          ),

          NavigationDestination(
            icon: Icon(Icons.verified_outlined),
            selectedIcon: Icon(Icons.verified),
            label: 'Verification',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (currentIndex) {
      case 0:
        return const LawyerHomeScreen();

      case 1:
        return const Center(
          child: Text(
            'Clients',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case 2:
        return const Center(
          child: Text(
            'Drafting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case 3:
        return const Center(
          child: Text(
            'Laws',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case 4:
  return const VerificationScreen();

      default:
        return const LawyerHomeScreen();
    }
  }
}
import 'package:flutter/material.dart';


import 'package:lawlink360/core/features/client/screens/client_dashboard_screen.dart';

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
    Scaffold(
      body: Center(child: Text("Find Lawyer")),
    ),

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
            label: "Lawyers",
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: "Cases",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: "Activity",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
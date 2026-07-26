import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client/screens/client_dashboard_screen.dart';
import 'package:lawlink360/core/features/client/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client/screens/chat_screen.dart';

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
    ChatScreen(),

    Scaffold(
      body: Center(
        child: Text("Documents - Coming Soon"),
      ),
    ),

    Scaffold(
      body: Center(
        child: Text("Profile - Coming Soon"),
      ),
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
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: "Chat",
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: "Documents",
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
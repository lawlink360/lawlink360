import 'package:flutter/material.dart';

class AdminBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const AdminBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  static const List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_outline),
      activeIcon: Icon(Icons.people),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.gavel_outlined),
      activeIcon: Icon(Icons.gavel),
      label: 'Lawyers',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.verified_outlined),
      activeIcon: Icon(Icons.verified),
      label: 'Verification',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      activeIcon: Icon(Icons.more_horiz),
      label: 'More',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemSelected,
      type: BottomNavigationBarType.fixed,
      items: _items,
    );
  }
}
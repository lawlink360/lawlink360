import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String greeting;
  final String name;

  const HomeHeader({super.key, required this.greeting, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 55, 24, 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  greeting,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  overflow: TextOverflow.ellipsis, // Add this
                ),
              ),
              const Icon(Icons.notifications_none_rounded, color: Colors.white),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFD4AF37),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const Spacer(), // Add this to push content down
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis, // Add this
          ),
          const SizedBox(height: 8),
          const Text(
            "Your Legal Companion",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 4), // Add this for bottom spacing
        ],
      ),
    );
  }
}
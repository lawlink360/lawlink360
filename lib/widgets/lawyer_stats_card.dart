import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.35,
        children: const [

          _Item(
            icon: Icons.workspace_premium,
            value: "10+",
            title: "Years Experience",
          ),

          _Item(
            icon: Icons.gavel,
            value: "1,250+",
            title: "Cases Handled",
          ),

          _Item(
            icon: Icons.people_alt_outlined,
            value: "980+",
            title: "Happy Clients",
          ),

          _Item(
            icon: Icons.emoji_events_outlined,
            value: "95%",
            title: "Success Rate",
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const _Item({
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 32,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
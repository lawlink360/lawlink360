import 'package:flutter/material.dart';

class RecentCaseCard extends StatelessWidget {
  const RecentCaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.gavel,
            color: Colors.deepPurple,
            size: 34,
          ),

          SizedBox(width: 14),

          Expanded(
            child: Text(
              "No active cases available.",
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RecentDocumentsCard extends StatelessWidget {
  const RecentDocumentsCard({super.key});

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
            Icons.history,
            color: Color(0xFF0F172A),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              "Recently opened documents will appear here.",
            ),
          ),
        ],
      ),
    );
  }
}
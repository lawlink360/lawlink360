import 'package:flutter/material.dart';

class DocumentEmptyState extends StatelessWidget {
  const DocumentEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 45,
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFF13294B).withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.folder_off_outlined,
              color: Color(0xFF13294B),
              size: 40,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No Documents Found',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF13294B),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Your documents will appear here once you create, receive, or save them.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
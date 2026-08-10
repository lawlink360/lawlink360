import 'package:flutter/material.dart';

class VideoBottomTools extends StatelessWidget {
  const VideoBottomTools({super.key});

  Widget _tool(
    IconData icon,
    String title,
  ) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.10),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _tool(Icons.chat_outlined, "Chat"),
          _tool(Icons.description_outlined, "Document"),
          _tool(Icons.edit_note_outlined, "Notes"),
          _tool(Icons.calendar_month_outlined, "Follow-up"),
        ],
      ),
    );
  }
}
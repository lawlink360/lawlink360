import 'package:flutter/material.dart';

class ChatQuickActionBar extends StatelessWidget {
  const ChatQuickActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _QuickAction(Icons.attach_file, "File"),
          _QuickAction(Icons.camera_alt_outlined, "Camera"),
          _QuickAction(Icons.photo_outlined, "Gallery"),
          _QuickAction(Icons.mic_none, "Voice"),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;

  const _QuickAction(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFD4AF37),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client/screens/chat_screen.dart';
import 'package:lawlink360/core/features/client/screens/video_consultation_screen.dart';
import 'package:lawlink360/core/features/client/screens/voice_call_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ActionButton(
            icon: Icons.search,
            title: "Find Lawyer",
            color: const Color(0xFF0D1B2A),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindLawyerScreen(),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.call_outlined,
            title: "Call",
            color: const Color(0xFF0D1B2A),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VoiceCallScreen()),
              );
            },
          ),
          _ActionButton(
            icon: Icons.videocam_outlined,
            title: "Video",
            color: const Color(0xFF0D1B2A),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VideoConsultationScreen(),
                ),
              );
            },
          ),
          _ActionButton(
            icon: Icons.chat_bubble_outline,
            title: "Chat",
            color: const Color(0xFF0D1B2A),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

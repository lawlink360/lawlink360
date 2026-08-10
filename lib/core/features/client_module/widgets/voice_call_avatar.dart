import 'package:flutter/material.dart';

class VoiceCallAvatar extends StatelessWidget {
  const VoiceCallAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        // Outer Ring
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFD4AF37).withOpacity(0.08),
          ),
        ),

        // Middle Ring
        Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFD4AF37).withOpacity(0.15),
          ),
        ),

        // Main Avatar
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFD4AF37),
              width: 4,
            ),
          ),
          child: const Icon(
            Icons.person,
            size: 90,
            color: Color(0xFF0D1B2A),
          ),
        ),

        // Online Indicator
        Positioned(
          right: 58,
          bottom: 58,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
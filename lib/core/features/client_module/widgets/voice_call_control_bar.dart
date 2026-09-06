import 'package:flutter/material.dart';

import 'voice_end_call_dialog.dart';

class VoiceCallControlBar extends StatelessWidget {
  const VoiceCallControlBar({super.key});

  Widget _controlButton(
    BuildContext context,
    IconData icon,
    Color background,
    Color iconColor, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:.18),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlButton(
            context,
            Icons.mic_off,
            Colors.white,
            Colors.black87,
          ),

          _controlButton(
            context,
            Icons.volume_up,
            Colors.white,
            Colors.black87,
          ),

          _controlButton(
            context,
            Icons.bluetooth_audio,
            const Color(0xFFD4AF37),
            Colors.white,
          ),

          _controlButton(
            context,
            Icons.call_end,
            Colors.red,
            Colors.white,
            onTap: () {
              VoiceEndCallDialog.show(context);
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'video_end_call_dialog.dart';

class VideoControlBar extends StatelessWidget {
  const VideoControlBar({super.key});

  Widget _controlButton(
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
            Icons.mic_off,
            Colors.white,
            Colors.black87,
          ),

          _controlButton(
            Icons.videocam_off,
            Colors.white,
            Colors.black87,
          ),

          _controlButton(
            Icons.cameraswitch,
            const Color(0xFFD4AF37),
            Colors.white,
          ),

          _controlButton(
  Icons.call_end,
  Colors.red,
  Colors.white,
  onTap: () {
    VideoEndCallDialog.show(context);
  },
),
        ],
      ),
    );
  }
}
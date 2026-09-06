import 'package:flutter/material.dart';

class VideoAppBar extends StatelessWidget {
  const VideoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Row(
        children: [

          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha:.30),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              children: [

                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 16,
                ),

                SizedBox(width: 6),

                Text(
                  "00:00",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
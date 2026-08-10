import 'package:flutter/material.dart';

class ChatDateDivider extends StatelessWidget {
  const ChatDateDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEFF4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Text(
          "Today",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
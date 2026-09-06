import 'package:flutter/material.dart';

class SuccessAnimation extends StatelessWidget {
  const SuccessAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [

          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD4AF37).withValues(alpha:0.08),
            ),
          ),

          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD4AF37).withValues(alpha:0.18),
            ),
          ),

          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD4AF37),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 60,
            ),
          ),
        ],
      ),
    );
  }
}
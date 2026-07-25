import 'package:flutter/material.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Set colors based on theme
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;
    final shadowColor = const Color(0xFFD4AF37).withOpacity(0.35);

    return Column(
      children: [
        const SizedBox(height: 0),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 45,
                    spreadRadius: 6,
                  ),
                ],
              ),
            ),
            Image.asset(
              "assets/logos/lawlink360_transparent_logo.png",
              height: 75,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "LawLink360",
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Join Pakistan's Smart Legal Platform",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: subtitleColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';

class BiometricButton extends StatefulWidget {
  final VoidCallback onPressed;

  const BiometricButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<BiometricButton> createState() => _BiometricButtonState();
}

class _BiometricButtonState extends State<BiometricButton> {
  bool _pressed = false;
  bool _glow = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (mounted) {
        setState(() {
          _glow = !_glow;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Set colors based on theme
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white54 : Colors.black54;
    final buttonBgColor = isDark 
        ? Colors.white.withValues(alpha: 0.1) 
        : Colors.black.withValues(alpha: 0.05);
    final borderColor = const Color(0xFFD4AF37);
    final shadowColor = const Color(0xFFD4AF37).withValues(alpha: 0.3);

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.94 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: buttonBgColor,
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.fingerprint,
                size: 40,
                color: Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Login with Fingerprint",
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Use your device biometrics",
              style: TextStyle(
                color: subtitleColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
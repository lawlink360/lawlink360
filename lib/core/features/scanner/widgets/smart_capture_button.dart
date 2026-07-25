import 'package:flutter/material.dart';

class SmartCaptureButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SmartCaptureButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 82,
        height: 82,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
        ),
        child: Center(
          child: Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD4AF37),
            ),
          ),
        ),
      ),
    );
  }
}
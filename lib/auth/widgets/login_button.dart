import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: _pressed ? 0.97 : 1,
      child: SizedBox(
        width: double.infinity,
        height: 58,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
  setState(() => _pressed = false);

  if (!widget.isLoading) {
    widget.onPressed();
  }
},
          onTapCancel: () => setState(() => _pressed = false),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF8E08A),
                  Color(0xFFD4AF37),
                  Color(0xFFB8860B),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: widget.isLoading ? null : widget.onPressed,
                child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    if (widget.isLoading)
      const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      )
    else
      const Icon(
        Icons.login_rounded,
        color: Colors.black,
        size: 22,
      ),

    const SizedBox(width: 10),

    Text(
      widget.isLoading ? "Signing in..." : "Login",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
  ],
),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
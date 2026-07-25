import 'package:flutter/material.dart';

class SocialLoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SocialLoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Set colors based on theme
    final textColor = isDark ? Colors.white : Colors.black;
    final buttonBgColor = isDark 
        ? Colors.white.withValues(alpha: 0.10) 
        : Colors.black.withValues(alpha: 0.05);
    final borderColor = isDark 
        ? Colors.white.withValues(alpha: 0.25) 
        : Colors.black.withValues(alpha: 0.15);
    final shadowColor = isDark 
        ? Colors.black.withValues(alpha: 0.18) 
        : Colors.black.withValues(alpha: 0.08);
    final progressColor = isDark ? Colors.white : Colors.black;

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
              color: buttonBgColor,
              border: Border.all(
                color: borderColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 18,
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
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                        ),
                      )
                    else
                      const Text(
                        "G",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: Color(0xFF4285F4),
                        ),
                      ),
                    const SizedBox(width: 10),
                    Text(
                      widget.isLoading
                          ? "Signing you in..."
                          : "Continue with Google",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
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
import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

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

    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) {
        if (mounted) {
          setState(() {
            _glow = !_glow;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    final subtitleColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final buttonBackground = isDark
        ? AppColors.darkSurface.withValues(alpha: 0.65)
        : AppColors.lightSurface.withValues(alpha: 0.85);

    final glowAlpha = _glow ? 0.45 : 0.20;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.94 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: buttonBackground,
                border: Border.all(
                  color: AppColors.accent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(
                      alpha: glowAlpha,
                    ),
                    blurRadius: _glow ? 24 : 14,
                    spreadRadius: _glow ? 6 : 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.fingerprint,
                size: 40,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Login with Fingerprint',
              style: AppTextStyles.bodySmall.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Use your device biometrics',
              style: AppTextStyles.caption.copyWith(
                color: subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
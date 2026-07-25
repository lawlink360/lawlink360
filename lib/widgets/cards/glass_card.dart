import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;

  const GlassCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 24,
          sigmaY: 24,
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),

            color: isDark
                ? colors.surface.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.55),

            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.10)
                  : Colors.black.withValues(alpha: 0.08),
              width: 1,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: isDark ? 0.30 : 0.08,
                ),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
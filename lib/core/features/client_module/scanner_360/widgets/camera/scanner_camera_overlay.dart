import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../models/scanner_mode.dart';

/// Guide-only document frame drawn over the camera preview.
///
/// This is a visual aid. It does not detect anything.
///
/// When [mode] is [ScannerMode.idCard], a landscape ID-1 / CNIC
/// guide is drawn. For all other modes, the existing A4 portrait
/// guide is drawn.
///
/// A mode-specific instruction is rendered above the capture
/// frame. Its vertical position is derived from the frame's
/// computed top edge so that it sits immediately above the frame
/// in every mode.
class ScannerCameraOverlay extends StatelessWidget {
  const ScannerCameraOverlay({
    super.key,
    required this.mode,
  });

  final ScannerMode mode;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          final frameTop = _frameTopFor(mode, size);
          const instructionHeight = AppSpacing.xxl;
          const gap = AppSpacing.sm;

          final top = (frameTop - instructionHeight - gap)
              .clamp(AppSpacing.sm, size.height);

          return Stack(
            children: [
              CustomPaint(
                painter: _ScannerCameraOverlayPainter(mode),
                child: const SizedBox.expand(),
              ),
              Positioned(
                top: top,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                height: instructionHeight,
                child: Center(
                  child: _ModeInstruction(mode: mode),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Returns the top edge of the capture frame for [mode] given
  /// the available [size]. Mirrors the painter's frame geometry.
  static double _frameTopFor(ScannerMode mode, Size size) {
    final double frameWidth;
    final double frameHeight;

    if (mode == ScannerMode.idCard) {
      frameWidth = size.width * 0.86;
      frameHeight = frameWidth / 1.586;
    } else {
      frameWidth = size.width * 0.82;
      frameHeight = frameWidth * 1.414;
    }

    return (size.height - frameHeight) / 2;
  }
}

class _ModeInstruction extends StatelessWidget {
  const _ModeInstruction({required this.mode});

  final ScannerMode mode;

  String get _text {
    switch (mode) {
      case ScannerMode.document:
        return 'Fit document into the frame';
      case ScannerMode.idCard:
        return 'Front — Fit ID card into the frame';
      case ScannerMode.batch:
        return 'Scan multiple pages';
      case ScannerMode.ocr:
        return 'Fit text into the frame';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.overlayDark,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        _text,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ScannerCameraOverlayPainter extends CustomPainter {
  const _ScannerCameraOverlayPainter(this.mode);

  final ScannerMode mode;

  @override
  void paint(Canvas canvas, Size size) {
    final double frameWidth;
    final double frameHeight;

    if (mode == ScannerMode.idCard) {
      // ID-1 / CNIC landscape ratio: 85.6 mm × 53.98 mm ≈ 1.586 : 1.
      frameWidth = size.width * 0.86;
      frameHeight = frameWidth / 1.586;
    } else {
      // Existing A4 portrait guide.
      frameWidth = size.width * 0.82;
      frameHeight = frameWidth * 1.414;
    }

    final left = (size.width - frameWidth) / 2;
    final top = (size.height - frameHeight) / 2;
    final frame = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, frameWidth, frameHeight),
      const Radius.circular(12),
    );

    // Dim the area outside the frame.
    final scrim = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()..addRRect(frame),
    );
    canvas.drawPath(
      scrim,
      Paint()..color = AppColors.overlayDark,
    );

    // Frame border.
    canvas.drawRRect(
      frame,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.accent,
    );

    // Corner ticks.
    const tickLen = 24.0;
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = AppColors.accent;

    void drawCorner(Offset pivot, double dx, double dy) {
      canvas.drawLine(
        pivot,
        pivot + Offset(tickLen * dx, 0),
        tickPaint,
      );
      canvas.drawLine(
        pivot,
        pivot + Offset(0, tickLen * dy),
        tickPaint,
      );
    }

    drawCorner(Offset(left, top), 1, 1);
    drawCorner(Offset(left + frameWidth, top), -1, 1);
    drawCorner(Offset(left, top + frameHeight), 1, -1);
    drawCorner(
      Offset(left + frameWidth, top + frameHeight),
      -1,
      -1,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerCameraOverlayPainter old) =>
      old.mode != mode;
}
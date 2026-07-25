import 'package:flutter/material.dart';

class DocumentCropPainter extends CustomPainter {
  final Offset topLeft;
  final Offset topRight;
  final Offset bottomLeft;
  final Offset bottomRight;

  DocumentCropPainter({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
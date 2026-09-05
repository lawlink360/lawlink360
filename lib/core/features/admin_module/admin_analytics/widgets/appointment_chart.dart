import 'package:flutter/material.dart';

import '../models/appointment_analytics_model.dart';

class AppointmentChart extends StatelessWidget {
  final List<AppointmentAnalyticsModel> data;
  final double height;

  const AppointmentChart({
    super.key,
    required this.data,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text('No appointment data available'),
        ),
      );
    }

    final maxTotal = data
        .map((item) => item.total)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _AppointmentPainter(
          data: data,
          maxTotal: maxTotal.toDouble(),
        ),
      ),
    );
  }
}

class _AppointmentPainter extends CustomPainter {
  final List<AppointmentAnalyticsModel> data;
  final double maxTotal;

  _AppointmentPainter({
    required this.data,
    required this.maxTotal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double leftPadding = 48.0;
    const double rightPadding = 16.0;
    const double topPadding = 20.0;
    const double bottomPadding = 36.0;

    final double chartWidth =
        size.width - leftPadding - rightPadding;

    final double chartHeight =
        size.height - topPadding - bottomPadding;

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.15)
      ..strokeWidth = 1;

    final barPaint = Paint()
      ..color = const Color(0xFFB08D57)
      ..style = PaintingStyle.fill;

    const int gridLines = 4;

    for (var i = 0; i <= gridLines; i++) {
      final double y =
          topPadding +
          chartHeight -
          (chartHeight * i / gridLines);

      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );

      final double value =
          maxTotal * i / gridLines;

      _drawText(
        canvas,
        value.round().toString(),
        Offset(4, y - 7),
        fontSize: 10,
        color: Colors.grey.shade600,
      );
    }

    final double slotWidth =
        chartWidth / data.length;

    final double barWidth =
        slotWidth * 0.55;

    for (var i = 0; i < data.length; i++) {
      final item = data[i];

      final double barHeight = maxTotal == 0.0
          ? 0.0
          : chartHeight *
              item.total.toDouble() /
              maxTotal;

      final double x =
          leftPadding +
          slotWidth * i +
          (slotWidth - barWidth) / 2;

      final double y =
          topPadding +
          chartHeight -
          barHeight;

      final Rect barRect = Rect.fromLTWH(
        x,
        y,
        barWidth,
        barHeight,
      );

      final RRect rect =
          RRect.fromRectAndRadius(
        barRect,
        const Radius.circular(6),
      );

      canvas.drawRRect(
        rect,
        barPaint,
      );

      _drawText(
        canvas,
        item.total.toString(),
        Offset(
          x + barWidth / 2 - 8,
          y - 18,
        ),
        fontSize: 10,
        color: Colors.grey.shade700,
      );

      _drawText(
        canvas,
        item.period,
        Offset(
          x + barWidth / 2 - 10,
          size.height - 25,
        ),
        fontSize: 11,
        color: Colors.grey.shade700,
      );
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset, {
    required double fontSize,
    required Color color,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(
    covariant _AppointmentPainter oldDelegate,
  ) {
    return oldDelegate.data != data ||
        oldDelegate.maxTotal != maxTotal;
  }
}
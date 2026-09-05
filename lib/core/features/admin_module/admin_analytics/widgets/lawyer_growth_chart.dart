import 'package:flutter/material.dart';

import '../models/lawyer_analytics_model.dart';

class LawyerGrowthChart extends StatelessWidget {
  final List<LawyerAnalyticsModel> data;
  final double height;

  const LawyerGrowthChart({
    super.key,
    required this.data,
    this.height = 240,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text('No lawyer growth data available'),
        ),
      );
    }

    final maxLawyers = data
        .map((item) => item.totalLawyers)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _LawyerGrowthPainter(
          data: data,
          maxLawyers: maxLawyers.toDouble(),
        ),
      ),
    );
  }
}

class _LawyerGrowthPainter extends CustomPainter {
  final List<LawyerAnalyticsModel> data;
  final double maxLawyers;

  _LawyerGrowthPainter({
    required this.data,
    required this.maxLawyers,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const leftPadding = 48.0;
    const rightPadding = 16.0;
    const topPadding = 20.0;
    const bottomPadding = 36.0;

    final chartWidth =
        size.width - leftPadding - rightPadding;
    final chartHeight =
        size.height - topPadding - bottomPadding;

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.15)
      ..strokeWidth = 1;

    final linePaint = Paint()
      ..color = const Color(0xFF1D3557)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = const Color(0xFF1D3557)
      ..style = PaintingStyle.fill;

    const gridLines = 4;

    for (var i = 0; i <= gridLines; i++) {
      final y =
          topPadding + chartHeight - (chartHeight * i / gridLines);

      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );

      final value = maxLawyers * i / gridLines;

      _drawText(
        canvas,
        value.round().toString(),
        Offset(4, y - 7),
        fontSize: 10,
        color: Colors.grey.shade600,
      );
    }

    final path = Path();

    for (var i = 0; i < data.length; i++) {
      final x = data.length == 1
          ? leftPadding + chartWidth / 2
          : leftPadding +
              chartWidth * i / (data.length - 1);

      final ratio = maxLawyers == 0
          ? 0
          : data[i].totalLawyers / maxLawyers;

      final y =
          topPadding + chartHeight - (chartHeight * ratio);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, linePaint);

    for (var i = 0; i < data.length; i++) {
      final x = data.length == 1
          ? leftPadding + chartWidth / 2
          : leftPadding +
              chartWidth * i / (data.length - 1);

      final ratio = maxLawyers == 0
          ? 0
          : data[i].totalLawyers / maxLawyers;

      final y =
          topPadding + chartHeight - (chartHeight * ratio);

      canvas.drawCircle(
        Offset(x, y),
        4,
        pointPaint,
      );

      _drawText(
        canvas,
        data[i].period,
        Offset(x - 10, size.height - 25),
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
  bool shouldRepaint(covariant _LawyerGrowthPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.maxLawyers != maxLawyers;
  }
}
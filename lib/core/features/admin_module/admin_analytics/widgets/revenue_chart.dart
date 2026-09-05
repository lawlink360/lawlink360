import 'package:flutter/material.dart';

import '../models/revenue_analytics_model.dart';

class RevenueChart extends StatelessWidget {
  final List<RevenueAnalyticsModel> data;
  final double height;

  const RevenueChart({
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
          child: Text('No revenue data available'),
        ),
      );
    }

    final maxRevenue = data
        .map((item) => item.revenue)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _RevenuePainter(
          data: data,
          maxRevenue: maxRevenue,
        ),
      ),
    );
  }
}

class _RevenuePainter extends CustomPainter {
  final List<RevenueAnalyticsModel> data;
  final double maxRevenue;

  _RevenuePainter({
    required this.data,
    required this.maxRevenue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const leftPadding = 60.0;
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

      final value = maxRevenue * i / gridLines;

      _drawText(
        canvas,
        _formatRevenue(value),
        Offset(4, y - 7),
        fontSize: 9,
        color: Colors.grey.shade600,
      );
    }

    final path = Path();

    for (var i = 0; i < data.length; i++) {
      final x = data.length == 1
          ? leftPadding + chartWidth / 2
          : leftPadding +
              chartWidth * i / (data.length - 1);

      final ratio =
          maxRevenue == 0 ? 0 : data[i].revenue / maxRevenue;

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

      final ratio =
          maxRevenue == 0 ? 0 : data[i].revenue / maxRevenue;

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

  String _formatRevenue(double value) {
    if (value >= 1000000) {
      return 'Rs ${(value / 1000000).toStringAsFixed(1)}M';
    }

    if (value >= 1000) {
      return 'Rs ${(value / 1000).toStringAsFixed(0)}K';
    }

    return 'Rs ${value.round()}';
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
  bool shouldRepaint(covariant _RevenuePainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.maxRevenue != maxRevenue;
  }
}
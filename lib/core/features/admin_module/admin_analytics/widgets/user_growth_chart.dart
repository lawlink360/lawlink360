import 'package:flutter/material.dart';

import '../models/user_analytics_model.dart';

class UserGrowthChart extends StatelessWidget {
  final List<UserAnalyticsModel> data;
  final double height;

  const UserGrowthChart({
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
          child: Text('No user growth data available'),
        ),
      );
    }

    final maxUsers = data
        .map((item) => item.totalUsers)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _UserGrowthPainter(
          data: data,
          maxUsers: maxUsers.toDouble(),
        ),
      ),
    );
  }
}

class _UserGrowthPainter extends CustomPainter {
  final List<UserAnalyticsModel> data;
  final double maxUsers;

  _UserGrowthPainter({
    required this.data,
    required this.maxUsers,
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
      ..color = const Color(0xFFB08D57)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = const Color(0xFFB08D57)
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

      final value = maxUsers * i / gridLines;

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

      final ratio =
          maxUsers == 0 ? 0 : data[i].totalUsers / maxUsers;

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
          maxUsers == 0 ? 0 : data[i].totalUsers / maxUsers;

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
  bool shouldRepaint(covariant _UserGrowthPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.maxUsers != maxUsers;
  }
}
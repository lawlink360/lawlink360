import 'package:flutter/material.dart';

class TransactionStatusChip extends StatelessWidget {
  final String status;

  const TransactionStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color color;

    switch (status) {
      case 'Completed':
        color = Colors.green;
      case 'Pending':
        color = Colors.orange;
      case 'Failed':
        color = Colors.red;
      case 'Refunded':
        color = Colors.blue;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
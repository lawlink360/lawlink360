import 'package:flutter/material.dart';

class NotificationTypeChip extends StatelessWidget {
  final String type;

  const NotificationTypeChip({
    super.key,
    required this.type,
  });

  IconData _icon() {
    switch (type.toLowerCase()) {
      case 'appointment':
        return Icons.calendar_month_outlined;
      case 'payment':
        return Icons.payments_outlined;
      case 'verification':
        return Icons.verified_outlined;
      case 'case':
        return Icons.folder_outlined;
      case 'account':
        return Icons.person_outline;
      case 'system':
        return Icons.settings_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _color() {
    switch (type.toLowerCase()) {
      case 'appointment':
        return Colors.blue;
      case 'payment':
        return Colors.green;
      case 'verification':
        return Colors.purple;
      case 'case':
        return Colors.orange;
      case 'account':
        return Colors.teal;
      case 'system':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _icon(),
            size: 14,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            type,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
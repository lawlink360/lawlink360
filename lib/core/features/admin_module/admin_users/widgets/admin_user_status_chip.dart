import 'package:flutter/material.dart';

class AdminUserStatusChip extends StatelessWidget {
  final String status;

  const AdminUserStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color backgroundColor;
    late final Color foregroundColor;
    late final IconData icon;

    switch (status.toLowerCase()) {
      case 'active':
        label = 'Active';
        backgroundColor = Colors.green.withValues(alpha: 0.12);
        foregroundColor = Colors.green.shade700;
        icon = Icons.check_circle_outline;
        break;

      case 'inactive':
        label = 'Inactive';
        backgroundColor = Colors.grey.withValues(alpha: 0.12);
        foregroundColor = Colors.grey.shade700;
        icon = Icons.pause_circle_outline;
        break;

      case 'suspended':
        label = 'Suspended';
        backgroundColor = Colors.red.withValues(alpha: 0.12);
        foregroundColor = Colors.red.shade700;
        icon = Icons.block_outlined;
        break;

      default:
        label = status;
        backgroundColor = Colors.blueGrey.withValues(alpha: 0.12);
        foregroundColor = Colors.blueGrey.shade700;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: foregroundColor,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
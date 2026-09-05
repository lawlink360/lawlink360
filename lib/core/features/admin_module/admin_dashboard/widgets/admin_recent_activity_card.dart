import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_dashboard/models/admin_activity_model.dart';

class AdminRecentActivityCard extends StatelessWidget {
  final AdminActivityModel activity;
  final VoidCallback? onTap;

  const AdminRecentActivityCard({
    super.key,
    required this.activity,
    this.onTap,
  });

  IconData _getIcon() {
    switch (activity.type.toLowerCase()) {
      case 'user':
        return Icons.person_outline;
      case 'lawyer':
        return Icons.gavel_outlined;
      case 'verification':
        return Icons.verified_outlined;
      case 'appointment':
        return Icons.event_outlined;
      case 'payment':
        return Icons.payments_outlined;
      case 'case':
        return Icons.folder_outlined;
      default:
        return Icons.history;
    }
  }

  String _formatTime(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }

    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 6,
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(
            alpha: 0.10,
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getIcon(),
          color: theme.colorScheme.primary,
          size: 21,
        ),
      ),
      title: Text(
        activity.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
            if (activity.actorName != null) ...[
              const SizedBox(height: 3),
              Text(
                'By ${activity.actorName}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
      trailing: Text(
        _formatTime(activity.timestamp),
        style: theme.textTheme.labelSmall,
      ),
      onTap: onTap,
    );
  }
}
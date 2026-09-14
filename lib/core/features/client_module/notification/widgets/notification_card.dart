import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import '../models/notification_type.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const NotificationCard({
    super.key,
    required this.notification,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isUnread = !notification.isRead;

    return Dismissible(
      key: ValueKey(notification.notificationId),
      direction: onDismiss == null
          ? DismissDirection.none
          : DismissDirection.endToStart,
      onDismissed: (_) => onDismiss?.call(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.red.shade700,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUnread
                  ? theme.colorScheme.primary.withValues(alpha: 0.035)
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUnread
                    ? theme.colorScheme.primary.withValues(alpha: 0.12)
                    : theme.dividerColor.withValues(alpha: 0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isUnread ? 0.035 : 0.02,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NotificationIcon(
                  type: notification.type,
                  isUnread: isUnread,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (isUnread) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        notification.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          height: 1.45,
                          color: theme.textTheme.bodySmall?.color
                              ?.withValues(alpha: 0.72),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            notification.type.label,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: BoxDecoration(
                              color: theme.dividerColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _formatTimestamp(notification.timestamp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.textTheme.labelSmall?.color
                                    ?.withValues(alpha: 0.55),
                              ),
                            ),
                          ),
                          if (notification.actionKey != null)
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 18,
                              color: theme.textTheme.bodySmall?.color
                                  ?.withValues(alpha: 0.45),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.isNegative) {
      return 'Just now';
    }

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }

    return '${timestamp.day.toString().padLeft(2, '0')}/'
        '${timestamp.month.toString().padLeft(2, '0')}/'
        '${timestamp.year}';
  }
}

class _NotificationIcon extends StatelessWidget {
  final NotificationType type;
  final bool isUnread;

  const _NotificationIcon({
    required this.type,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: isUnread ? 0.10 : 0.06,
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(
        _iconForType(type),
        size: 21,
        color: theme.colorScheme.primary.withValues(
          alpha: isUnread ? 0.95 : 0.65,
        ),
      ),
    );
  }

  IconData _iconForType(NotificationType type) {
    switch (type) {
      case NotificationType.appointment:
        return Icons.calendar_month_rounded;
      case NotificationType.caseUpdate:
        return Icons.folder_copy_outlined;
      case NotificationType.message:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.document:
        return Icons.description_outlined;
      case NotificationType.payment:
        return Icons.payments_outlined;
      case NotificationType.verification:
        return Icons.verified_user_outlined;
      case NotificationType.system:
        return Icons.info_outline_rounded;
      case NotificationType.actionRequired:
        return Icons.priority_high_rounded;
    }
  }
}
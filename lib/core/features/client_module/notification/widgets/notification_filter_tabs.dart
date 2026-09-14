import 'package:flutter/material.dart';

import '../models/notification_type.dart';

class NotificationFilterTabs extends StatelessWidget {
  final NotificationType? selectedType;
  final ValueChanged<NotificationType?> onChanged;

  const NotificationFilterTabs({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filters = <_NotificationFilter>[
      const _NotificationFilter(
        label: 'All',
        type: null,
      ),
      _NotificationFilter(
        label: NotificationType.appointment.label,
        type: NotificationType.appointment,
      ),
      _NotificationFilter(
        label: NotificationType.caseUpdate.label,
        type: NotificationType.caseUpdate,
      ),
      _NotificationFilter(
        label: NotificationType.message.label,
        type: NotificationType.message,
      ),
      _NotificationFilter(
        label: NotificationType.document.label,
        type: NotificationType.document,
      ),
      _NotificationFilter(
        label: NotificationType.payment.label,
        type: NotificationType.payment,
      ),
      _NotificationFilter(
        label: NotificationType.verification.label,
        type: NotificationType.verification,
      ),
      _NotificationFilter(
        label: NotificationType.actionRequired.label,
        type: NotificationType.actionRequired,
      ),
      _NotificationFilter(
        label: NotificationType.system.label,
        type: NotificationType.system,
      ),
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedType == filter.type;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChanged(filter.type),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.dividerColor.withValues(alpha: 0.12),
                  ),
                ),
                child: Text(
                  filter.label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.textTheme.bodyMedium?.color
                            ?.withValues(alpha: 0.72),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NotificationFilter {
  final String label;
  final NotificationType? type;

  const _NotificationFilter({
    required this.label,
    required this.type,
  });
}
import 'package:flutter/material.dart';

import '../models/audit_log_model.dart';

class AuditLogCard extends StatelessWidget {
  final AuditLogModel log;
  final VoidCallback? onTap;

  const AuditLogCard({
    super.key,
    required this.log,
    this.onTap,
  });

  Color _categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'authentication':
        return Colors.blue;
      case 'users':
        return Colors.orange;
      case 'lawyers':
        return Colors.purple;
      case 'verification':
        return Colors.teal;
      case 'payments':
        return Colors.green;
      case 'reports':
        return Colors.red;
      case 'appointments':
        return Colors.indigo;
      case 'cases':
        return Colors.brown;
      case 'notifications':
        return Colors.cyan;
      case 'settings':
        return Colors.grey;
      default:
        return const Color(0xFFC9A227);
    }
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'authentication':
        return Icons.login_rounded;
      case 'users':
        return Icons.people_alt_rounded;
      case 'lawyers':
        return Icons.gavel_rounded;
      case 'verification':
        return Icons.verified_user_rounded;
      case 'payments':
        return Icons.payments_rounded;
      case 'reports':
        return Icons.flag_rounded;
      case 'appointments':
        return Icons.calendar_month_rounded;
      case 'cases':
        return Icons.folder_rounded;
      case 'notifications':
        return Icons.notifications_active_rounded;
      case 'settings':
        return Icons.settings_rounded;
      default:
        return Icons.history_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
            ? 12
            : date.hour;

    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day}/${date.month}/${date.year} • '
        '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _categoryColor(log.category);
    final categoryIcon = _categoryIcon(log.category);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      categoryIcon,
                      color: categoryColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log.action,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF17233C),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          log.category,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: categoryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (log.targetName != null) ...[
                _InfoRow(
                  icon: Icons.person_outline_rounded,
                  label: 'Target',
                  value: log.targetName!,
                ),
                const SizedBox(height: 8),
              ],
              if (log.oldValue != null || log.newValue != null) ...[
                Row(
                  children: [
                    Expanded(
                      child: _ValueBox(
                        label: 'Old Value',
                        value: log.oldValue ?? '—',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ValueBox(
                        label: 'New Value',
                        value: log.newValue ?? '—',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
              _InfoRow(
                icon: Icons.admin_panel_settings_outlined,
                label: 'Actor',
                value: log.actorName,
              ),
              const SizedBox(height: 8),
              if (log.ipAddress != null) ...[
                _InfoRow(
                  icon: Icons.language_rounded,
                  label: 'IP Address',
                  value: log.ipAddress!,
                ),
                const SizedBox(height: 8),
              ],
              _InfoRow(
                icon: Icons.access_time_rounded,
                label: 'Date',
                value: _formatDate(log.createdAt),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: const Color(0xFF17233C).withValues(alpha: 0.65),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF17233C),
            ),
          ),
        ),
      ],
    );
  }
}

class _ValueBox extends StatelessWidget {
  final String label;
  final String value;

  const _ValueBox({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF17233C),
            ),
          ),
        ],
      ),
    );
  }
}
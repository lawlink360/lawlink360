import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_permission_model.dart';

class PermissionCard extends StatelessWidget {
  final AdminPermissionModel permission;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onTap;

  const PermissionCard({
    super.key,
    required this.permission,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: navy.withValues(alpha: 0.08),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _categoryIcon(permission.category),
                  color: gold,
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      permission.name,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      permission.key,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: navy.withValues(alpha: 0.50),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      permission.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: navy.withValues(alpha: 0.62),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: permission.isEnabled,
                onChanged: onChanged,
                activeThumbColor: gold,
                activeTrackColor: gold.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'users':
        return Icons.people_outline;
      case 'lawyers':
        return Icons.gavel_outlined;
      case 'verification':
        return Icons.verified_user_outlined;
      case 'appointments':
        return Icons.calendar_month_outlined;
      case 'cases':
        return Icons.folder_outlined;
      case 'payments':
        return Icons.payments_outlined;
      case 'notifications':
        return Icons.notifications_none;
      case 'reports':
        return Icons.report_outlined;
      case 'analytics':
        return Icons.analytics_outlined;
      case 'content':
        return Icons.article_outlined;
      case 'activity':
        return Icons.history;
      case 'settings':
        return Icons.settings_outlined;
      case 'administration':
        return Icons.admin_panel_settings_outlined;
      default:
        return Icons.security_outlined;
    }
  }
}
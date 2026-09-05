import 'package:flutter/material.dart';

import '../models/admin_activity_model.dart';

class AdminActivityCard extends StatelessWidget {
  final AdminActivityModel activity;
  final VoidCallback? onTap;

  const AdminActivityCard({
    super.key,
    required this.activity,
    this.onTap,
  });

  static const Color navy = Color(0xFF17233C);
  static const Color gold = Color(0xFFC9A227);

  @override
  Widget build(BuildContext context) {
    final icon = _getCategoryIcon(activity.category);
    final color = _getCategoryColor(activity.category);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.action,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: navy,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          activity.category,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(activity.createdAt),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 13),
              Text(
                activity.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(
                height: 1,
                color: Color(0xFFE5E7EB),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 17,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      activity.adminName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (activity.targetName != null) ...[
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 15,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        activity.targetName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: navy,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: gold,
                    size: 21,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'authentication':
        return Icons.lock_outline_rounded;
      case 'users':
        return Icons.people_outline_rounded;
      case 'lawyers':
        return Icons.gavel_rounded;
      case 'verification':
        return Icons.verified_user_outlined;
      case 'appointments':
        return Icons.calendar_month_outlined;
      case 'cases':
        return Icons.folder_open_outlined;
      case 'payments':
        return Icons.payments_outlined;
      case 'reports':
        return Icons.report_outlined;
      case 'notifications':
        return Icons.notifications_none_rounded;
      case 'settings':
        return Icons.settings_outlined;
      default:
        return Icons.history_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'authentication':
        return const Color(0xFF7C3AED);
      case 'users':
        return const Color(0xFF2563EB);
      case 'lawyers':
        return const Color(0xFF0F766E);
      case 'verification':
        return const Color(0xFF16A34A);
      case 'appointments':
        return const Color(0xFF0891B2);
      case 'cases':
        return const Color(0xFF9333EA);
      case 'payments':
        return const Color(0xFF15803D);
      case 'reports':
        return const Color(0xFFDC2626);
      case 'notifications':
        return const Color(0xFFD97706);
      case 'settings':
        return const Color(0xFF4B5563);
      default:
        return gold;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }
}
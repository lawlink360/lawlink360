import 'package:flutter/material.dart';

import '../models/admin_report_model.dart';
import 'report_status_chip.dart';

class AdminReportCard extends StatelessWidget {
  final AdminReportModel report;
  final VoidCallback? onTap;
  final VoidCallback? onAssign;
  final VoidCallback? onResolve;
  final VoidCallback? onDelete;

  const AdminReportCard({
    super.key,
    required this.report,
    this.onTap,
    this.onAssign,
    this.onResolve,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool hasAssignment =
        report.assignedToName != null &&
        report.assignedToName!.trim().isNotEmpty;

    final bool isFinalStatus =
        report.status == 'Resolved' ||
        report.status == 'Rejected' ||
        report.status == 'Closed';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReportIcon(
                    reportType: report.reportType,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF17233C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          report.id,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _PriorityBadge(
                    priority: report.priority,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Description
              Text(
                report.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 14),

              // Reporter / Target
              Row(
                children: [
                  Expanded(
                    child: _InfoItem(
                      icon: Icons.person_outline_rounded,
                      label: 'Reporter',
                      value: report.reporterName,
                    ),
                  ),
                  if (report.targetName != null)
                    Expanded(
                      child: _InfoItem(
                        icon: Icons.flag_outlined,
                        label: 'Target',
                        value: report.targetName!,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 14),

              Divider(
                height: 1,
                color: Colors.grey.withValues(alpha: 0.12),
              ),

              const SizedBox(height: 12),

              // Bottom row
              Row(
                children: [
                  ReportStatusChip(
                    status: report.status,
                    compact: true,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      report.reportType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _ActionMenu(
                    hasAssignment: hasAssignment,
                    isFinalStatus: isFinalStatus,
                    onAssign: onAssign,
                    onResolve: onResolve,
                    onDelete: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportIcon extends StatelessWidget {
  final String reportType;

  const _ReportIcon({
    required this.reportType,
  });

  @override
  Widget build(BuildContext context) {
    final IconData icon;

    switch (reportType.toLowerCase()) {
      case 'payment':
        icon = Icons.payments_outlined;
        break;
      case 'verification':
        icon = Icons.verified_user_outlined;
        break;
      case 'lawyer conduct':
        icon = Icons.gavel_rounded;
        break;
      case 'user conduct':
        icon = Icons.person_off_outlined;
        break;
      case 'case management':
        icon = Icons.folder_outlined;
        break;
      case 'account':
        icon = Icons.account_circle_outlined;
        break;
      case 'privacy':
        icon = Icons.privacy_tip_outlined;
        break;
      case 'content':
        icon = Icons.article_outlined;
        break;
      default:
        icon = Icons.report_outlined;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFC9A227).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: const Color(0xFFC9A227),
        size: 22,
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    final String normalized = priority.toLowerCase();

    final Color color;

    switch (normalized) {
      case 'critical':
      case 'urgent':
        color = const Color(0xFFDC2626);
        break;
      case 'high':
        color = const Color(0xFFEA580C);
        break;
      case 'medium':
        color = const Color(0xFFF59E0B);
        break;
      case 'low':
        color = const Color(0xFF16A34A);
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
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
          size: 16,
          color: Colors.grey.shade500,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionMenu extends StatelessWidget {
  final bool hasAssignment;
  final bool isFinalStatus;
  final VoidCallback? onAssign;
  final VoidCallback? onResolve;
  final VoidCallback? onDelete;

  const _ActionMenu({
    required this.hasAssignment,
    required this.isFinalStatus,
    this.onAssign,
    this.onResolve,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Report actions',
      icon: Icon(
        Icons.more_vert_rounded,
        color: Colors.grey.shade600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onSelected: (value) {
        switch (value) {
          case 'assign':
            onAssign?.call();
            break;
          case 'resolve':
            onResolve?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'assign',
          child: Row(
            children: [
              Icon(
                hasAssignment
                    ? Icons.person_outline_rounded
                    : Icons.person_add_alt_1_rounded,
                size: 19,
              ),
              const SizedBox(width: 10),
              Text(
                hasAssignment ? 'Reassign' : 'Assign',
              ),
            ],
          ),
        ),
        if (!isFinalStatus)
          const PopupMenuItem<String>(
            value: 'resolve',
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 19,
                ),
                SizedBox(width: 10),
                Text('Resolve'),
              ],
            ),
          ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 19,
              ),
              SizedBox(width: 10),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );
  }
}
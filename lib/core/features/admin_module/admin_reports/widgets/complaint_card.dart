import 'package:flutter/material.dart';

import '../models/complaint_model.dart';
import 'report_status_chip.dart';

class ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;
  final VoidCallback? onTap;
  final VoidCallback? onAssign;
  final VoidCallback? onResolve;
  final VoidCallback? onDelete;

  const ComplaintCard({
    super.key,
    required this.complaint,
    this.onTap,
    this.onAssign,
    this.onResolve,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bool hasAssignment =
        complaint.assignedToName != null &&
        complaint.assignedToName!.trim().isNotEmpty;

    final bool isFinalStatus =
        complaint.status == 'Resolved' ||
        complaint.status == 'Rejected' ||
        complaint.status == 'Closed';

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC9A227)
                          .withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.feedback_outlined,
                      color: Color(0xFFC9A227),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaint.subject,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF17233C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          complaint.id,
                          style:
                              theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _ComplaintPriorityBadge(
                    priority: complaint.priority,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                complaint.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _ComplaintInfoItem(
                      icon: Icons.person_outline_rounded,
                      label: 'Complainant',
                      value: complaint.complainantName,
                    ),
                  ),
                  if (complaint.againstName != null)
                    Expanded(
                      child: _ComplaintInfoItem(
                        icon: Icons.report_gmailerrorred_outlined,
                        label: 'Against',
                        value: complaint.againstName!,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      complaint.category,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ReportStatusChip(
                    status: complaint.status,
                    compact: true,
                  ),
                  const Spacer(),
                  _ComplaintActionMenu(
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

class _ComplaintPriorityBadge extends StatelessWidget {
  final String priority;

  const _ComplaintPriorityBadge({
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    final String normalized =
        priority.toLowerCase();

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

class _ComplaintInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ComplaintInfoItem({
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
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

class _ComplaintActionMenu extends StatelessWidget {
  final bool hasAssignment;
  final bool isFinalStatus;
  final VoidCallback? onAssign;
  final VoidCallback? onResolve;
  final VoidCallback? onDelete;

  const _ComplaintActionMenu({
    required this.hasAssignment,
    required this.isFinalStatus,
    this.onAssign,
    this.onResolve,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Complaint actions',
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
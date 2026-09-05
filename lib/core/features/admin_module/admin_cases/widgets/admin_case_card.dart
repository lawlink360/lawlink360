import 'package:flutter/material.dart';

import '../models/admin_case_model.dart';
import 'case_status_chip.dart';

class AdminCaseCard extends StatelessWidget {
  final AdminCaseModel caseItem;
  final VoidCallback? onTap;
  final VoidCallback? onActivate;
  final VoidCallback? onHold;
  final VoidCallback? onClose;
  final VoidCallback? onDismiss;

  const AdminCaseCard({
    super.key,
    required this.caseItem,
    this.onTap,
    this.onActivate,
    this.onHold,
    this.onClose,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.gavel_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          caseItem.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          caseItem.caseNumber,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CaseStatusChip(
                    status: caseItem.status,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _InfoRow(
                icon: Icons.person_outline_rounded,
                label: 'Client',
                value: caseItem.clientName,
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.account_balance_rounded,
                label: 'Lawyer',
                value: caseItem.lawyerName,
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Pending Fee',
                value: 'PKR ${caseItem.pendingAmount.toStringAsFixed(0)}',
              ),
              if (caseItem.nextHearingDate != null) ...[
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.event_outlined,
                  label: 'Next Hearing',
                  value: _formatDate(caseItem.nextHearingDate!),
                ),
              ],
              const SizedBox(height: 14),
              Row(
                children: [
                  _TypeBadge(
                    label: caseItem.caseType,
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    tooltip: 'Case actions',
                    onSelected: (value) {
                      switch (value) {
                        case 'activate':
                          onActivate?.call();
                          break;
                        case 'hold':
                          onHold?.call();
                          break;
                        case 'close':
                          onClose?.call();
                          break;
                        case 'dismiss':
                          onDismiss?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'activate',
                        child: Text('Mark Active'),
                      ),
                      PopupMenuItem(
                        value: 'hold',
                        child: Text('Put On Hold'),
                      ),
                      PopupMenuItem(
                        value: 'close',
                        child: Text('Close Case'),
                      ),
                      PopupMenuItem(
                        value: 'dismiss',
                        child: Text('Dismiss Case'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
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
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String label;

  const _TypeBadge({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/admin_case_model.dart';
import '../models/case_status_model.dart';
import '../providers/admin_cases_provider.dart';
import '../widgets/case_status_chip.dart';

class AdminCaseDetailsScreen extends ConsumerWidget {
  final String caseId;

  const AdminCaseDetailsScreen({
    super.key,
    required this.caseId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminCasesProvider.notifier);
    final caseItem = notifier.getCaseById(caseId);

    if (caseItem == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Case Details'),
        ),
        body: const Center(
          child: Text('Case not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(context, caseItem),
            const SizedBox(height: 16),
            _buildCaseInformation(context, caseItem),
            const SizedBox(height: 16),
            _buildClientInformation(context, caseItem),
            const SizedBox(height: 16),
            _buildLawyerInformation(context, caseItem),
            const SizedBox(height: 16),
            _buildFinancialInformation(context, caseItem),
            const SizedBox(height: 16),
            _buildHearingInformation(context, caseItem),
            if (caseItem.notes != null &&
                caseItem.notes!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildNotes(context, caseItem),
            ],
            const SizedBox(height: 24),
            _buildStatusActions(context, ref, caseItem),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      theme.colorScheme.primary.withValues(alpha: 0.10),
                  child: Icon(
                    Icons.gavel_rounded,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caseItem.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        caseItem.caseNumber,
                        style: theme.textTheme.bodyMedium?.copyWith(
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
            const SizedBox(height: 18),
            Text(
              caseItem.description,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaseInformation(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    return _InformationCard(
      title: 'Case Information',
      icon: Icons.folder_copy_outlined,
      children: [
        _DetailRow(
          label: 'Case Type',
          value: caseItem.caseType,
        ),
        _DetailRow(
          label: 'Court',
          value: caseItem.courtName,
        ),
        _DetailRow(
          label: 'Location',
          value: caseItem.courtLocation,
        ),
        _DetailRow(
          label: 'Filing Date',
          value: _formatDate(caseItem.filingDate),
        ),
        if (caseItem.judgeName != null)
          _DetailRow(
            label: 'Judge',
            value: caseItem.judgeName!,
          ),
      ],
    );
  }

  Widget _buildClientInformation(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    return _InformationCard(
      title: 'Client Information',
      icon: Icons.person_outline_rounded,
      children: [
        _DetailRow(
          label: 'Name',
          value: caseItem.clientName,
        ),
        _DetailRow(
          label: 'Email',
          value: caseItem.clientEmail,
        ),
        _DetailRow(
          label: 'Phone',
          value: caseItem.clientPhone,
        ),
        _DetailRow(
          label: 'Client ID',
          value: caseItem.clientId,
        ),
      ],
    );
  }

  Widget _buildLawyerInformation(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    return _InformationCard(
      title: 'Lawyer Information',
      icon: Icons.account_balance_outlined,
      children: [
        _DetailRow(
          label: 'Name',
          value: caseItem.lawyerName,
        ),
        _DetailRow(
          label: 'Specialization',
          value: caseItem.lawyerSpecialization,
        ),
        _DetailRow(
          label: 'Lawyer ID',
          value: caseItem.lawyerId,
        ),
      ],
    );
  }

  Widget _buildFinancialInformation(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    return _InformationCard(
      title: 'Financial Information',
      icon: Icons.account_balance_wallet_outlined,
      children: [
        _DetailRow(
          label: 'Total Fee',
          value: 'PKR ${caseItem.totalFee.toStringAsFixed(0)}',
        ),
        _DetailRow(
          label: 'Paid Amount',
          value: 'PKR ${caseItem.paidAmount.toStringAsFixed(0)}',
        ),
        _DetailRow(
          label: 'Pending Amount',
          value: 'PKR ${caseItem.pendingAmount.toStringAsFixed(0)}',
          isHighlighted: caseItem.pendingAmount > 0,
        ),
      ],
    );
  }

  Widget _buildHearingInformation(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    return _InformationCard(
      title: 'Hearing Information',
      icon: Icons.event_outlined,
      children: [
        _DetailRow(
          label: 'Next Hearing',
          value: caseItem.nextHearingDate == null
              ? 'Not scheduled'
              : _formatDate(caseItem.nextHearingDate!),
        ),
        _DetailRow(
          label: 'Last Updated',
          value: _formatDate(caseItem.updatedAt),
        ),
      ],
    );
  }

  Widget _buildNotes(
    BuildContext context,
    AdminCaseModel caseItem,
  ) {
    return _InformationCard(
      title: 'Notes',
      icon: Icons.notes_rounded,
      children: [
        Text(
          caseItem.notes!,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildStatusActions(
    BuildContext context,
    WidgetRef ref,
    AdminCaseModel caseItem,
  ) {
    final notifier = ref.read(adminCasesProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Case Status',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatusButton(
              label: 'Pending',
              icon: Icons.pending_actions_rounded,
              onPressed: () {
                notifier.updateCaseStatus(
                  caseItem.id,
                  CaseStatusModel.pending,
                );
              },
            ),
            _StatusButton(
              label: 'Active',
              icon: Icons.play_circle_outline_rounded,
              onPressed: () {
                notifier.updateCaseStatus(
                  caseItem.id,
                  CaseStatusModel.active,
                );
              },
            ),
            _StatusButton(
              label: 'On Hold',
              icon: Icons.pause_circle_outline_rounded,
              onPressed: () {
                notifier.updateCaseStatus(
                  caseItem.id,
                  CaseStatusModel.onHold,
                );
              },
            ),
            _StatusButton(
              label: 'Closed',
              icon: Icons.check_circle_outline_rounded,
              onPressed: () {
                notifier.updateCaseStatus(
                  caseItem.id,
                  CaseStatusModel.closed,
                );
              },
            ),
            _StatusButton(
              label: 'Dismissed',
              icon: Icons.cancel_outlined,
              onPressed: () {
                notifier.updateCaseStatus(
                  caseItem.id,
                  CaseStatusModel.dismissed,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _InformationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InformationCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlighted;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight:
                    isHighlighted ? FontWeight.w700 : FontWeight.w500,
                color: isHighlighted
                    ? theme.colorScheme.error
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _StatusButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(label),
    );
  }
}
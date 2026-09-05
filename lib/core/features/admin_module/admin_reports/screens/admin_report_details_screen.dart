import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_reports/providers/admin_reports_provider.dart';
import '../../widgets/admin_empty_state.dart';
import '../../widgets/admin_error_state.dart';
import '../../widgets/admin_loading_state.dart';
import '../models/admin_report_model.dart';
import '../models/complaint_model.dart';
import '../models/report_status_model.dart';
import '../widgets/report_status_chip.dart';

class AdminReportDetailsScreen extends ConsumerStatefulWidget {
  final String? reportId;
  final String? complaintId;

  const AdminReportDetailsScreen({super.key, this.reportId, this.complaintId});

  @override
  ConsumerState<AdminReportDetailsScreen> createState() =>
      _AdminReportDetailsScreenState();
}

class _AdminReportDetailsScreenState
    extends ConsumerState<AdminReportDetailsScreen> {
  static const Color navy = Color(0xFF17233C);
  static const Color gold = Color(0xFFC9A227);

  bool get isReport => widget.reportId != null;

  @override
  Widget build(BuildContext context) {
    final reportsState = ref.watch(adminReportsProvider);
    final complaintsState = ref.watch(adminComplaintsProvider);

    if (isReport) {
      return reportsState.when(
        loading: () => const Scaffold(
          backgroundColor: Colors.white,
          body: AdminLoadingState(),
        ),
        error: (error, stackTrace) => Scaffold(
          backgroundColor: Colors.white,
          body: AdminErrorState(message: error.toString()),
        ),
        data: (_) {
          final report = ref
              .read(adminReportsProvider.notifier)
              .getReportById(widget.reportId!);

          if (report == null) {
            return _buildNotFound(
              title: 'Report Not Found',
              message: 'The requested report could not be found.',
            );
          }

          return _buildReportDetails(report);
        },
      );
    }

    return complaintsState.when(
      loading: () => const Scaffold(
        backgroundColor: Colors.white,
        body: AdminLoadingState(),
      ),
      error: (error, stackTrace) => Scaffold(
        backgroundColor: Colors.white,
        body: AdminErrorState(message: error.toString()),
      ),
      data: (_) {
        if (widget.complaintId == null) {
          return _buildNotFound(
            title: 'Details Not Found',
            message: 'No report or complaint was selected.',
          );
        }

        final complaint = ref
            .read(adminComplaintsProvider.notifier)
            .getComplaintById(widget.complaintId!);

        if (complaint == null) {
          return _buildNotFound(
            title: 'Complaint Not Found',
            message: 'The requested complaint could not be found.',
          );
        }

        return _buildComplaintDetails(complaint);
      },
    );
  }

  Widget _buildReportDetails(AdminReportModel report) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Report Details',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'More Actions',
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () => _showReportActions(report),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(adminReportsProvider.notifier).refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeaderCard(
              title: report.title,
              subtitle: 'Report ID: ${report.id}',
              icon: _reportIcon(report.reportType),
              status: report.status,
              priority: report.priority,
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Report Information',
              icon: Icons.description_outlined,
              children: [
                _detailRow('Report Type', report.reportType),
                _detailRow('Priority', report.priority),
                _detailRow('Status', report.status),
                _detailRow('Created', _formatDateTime(report.createdAt)),
                _detailRow('Last Updated', _formatDateTime(report.updatedAt)),
                if (report.resolvedAt != null)
                  _detailRow('Resolved', _formatDateTime(report.resolvedAt!)),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Description',
              icon: Icons.subject_rounded,
              children: [_descriptionText(report.description)],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Reporter',
              icon: Icons.person_outline_rounded,
              children: [
                _detailRow('Name', report.reporterName),
                _detailRow('User ID', report.reporterId),
                if (report.reporterEmail != null)
                  _detailRow('Email', report.reporterEmail!),
              ],
            ),
            if (report.targetId != null ||
                report.targetName != null ||
                report.targetType != null) ...[
              const SizedBox(height: 16),
              _buildSection(
                title: 'Reported Target',
                icon: Icons.flag_outlined,
                children: [
                  if (report.targetName != null)
                    _detailRow('Name', report.targetName!),
                  if (report.targetId != null)
                    _detailRow('ID', report.targetId!),
                  if (report.targetType != null)
                    _detailRow('Type', report.targetType!),
                ],
              ),
            ],
            const SizedBox(height: 16),
            _buildAssignmentSection(
              assignedTo: report.assignedTo,
              assignedToName: report.assignedToName,
              onAssign: () => _assignReport(report),
            ),
            if (report.resolution != null &&
                report.resolution!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildSection(
                title: 'Resolution',
                icon: Icons.check_circle_outline_rounded,
                children: [_descriptionText(report.resolution!)],
              ),
            ],
            const SizedBox(height: 24),
            _buildActionButtons(
              status: report.status,
              onStatusChange: () => _showStatusDialog(
                isReportItem: true,
                id: report.id,
                currentStatus: report.status,
              ),
              onResolve: _isFinalStatus(report.status)
                  ? null
                  : () => _resolveReport(report),
              onDelete: () => _deleteReport(report),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintDetails(ComplaintModel complaint) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Complaint Details',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'More Actions',
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () => _showComplaintActions(complaint),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(adminComplaintsProvider.notifier).refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeaderCard(
              title: complaint.subject,
              subtitle: 'Complaint ID: ${complaint.id}',
              icon: Icons.report_problem_outlined,
              status: complaint.status,
              priority: complaint.priority,
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Complaint Information',
              icon: Icons.description_outlined,
              children: [
                _detailRow('Category', complaint.category),
                _detailRow('Priority', complaint.priority),
                _detailRow('Status', complaint.status),
                _detailRow('Created', _formatDateTime(complaint.createdAt)),
                _detailRow(
                  'Last Updated',
                  _formatDateTime(complaint.updatedAt),
                ),
                if (complaint.resolvedAt != null)
                  _detailRow(
                    'Resolved',
                    _formatDateTime(complaint.resolvedAt!),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Description',
              icon: Icons.subject_rounded,
              children: [_descriptionText(complaint.description)],
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Complainant',
              icon: Icons.person_outline_rounded,
              children: [
                _detailRow('Name', complaint.complainantName),
                _detailRow('User ID', complaint.complainantId),
                if (complaint.complainantEmail != null)
                  _detailRow('Email', complaint.complainantEmail!),
              ],
            ),
            if (complaint.againstId != null ||
                complaint.againstName != null ||
                complaint.againstType != null) ...[
              const SizedBox(height: 16),
              _buildSection(
                title: 'Complaint Against',
                icon: Icons.person_search_outlined,
                children: [
                  if (complaint.againstName != null)
                    _detailRow('Name', complaint.againstName!),
                  if (complaint.againstId != null)
                    _detailRow('ID', complaint.againstId!),
                  if (complaint.againstType != null)
                    _detailRow('Type', complaint.againstType!),
                ],
              ),
            ],
            const SizedBox(height: 16),
            _buildAssignmentSection(
              assignedTo: complaint.assignedTo,
              assignedToName: complaint.assignedToName,
              onAssign: () => _assignComplaint(complaint),
            ),
            if (complaint.resolution != null &&
                complaint.resolution!.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildSection(
                title: 'Resolution',
                icon: Icons.check_circle_outline_rounded,
                children: [_descriptionText(complaint.resolution!)],
              ),
            ],
            const SizedBox(height: 24),
            _buildActionButtons(
              status: complaint.status,
              onStatusChange: () => _showStatusDialog(
                isReportItem: false,
                id: complaint.id,
                currentStatus: complaint.status,
              ),
              onResolve: _isFinalStatus(complaint.status)
                  ? null
                  : () => _resolveComplaint(complaint),
              onDelete: () => _deleteComplaint(complaint),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String status,
    required String priority,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: gold, size: 27),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: ReportStatusChip(status: status)),
              const SizedBox(width: 10),
              _priorityBadge(priority),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: navy, size: 20),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAssignmentSection({
    String? assignedTo,
    String? assignedToName,
    required VoidCallback onAssign,
  }) {
    final hasAssignment = assignedTo != null || assignedToName != null;

    return _buildSection(
      title: 'Assignment',
      icon: Icons.assignment_ind_outlined,
      children: [
        if (hasAssignment) ...[
          _detailRow('Assigned To', assignedToName ?? 'Admin'),
          if (assignedTo != null) _detailRow('Admin ID', assignedTo),
          const SizedBox(height: 8),
        ] else
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'This item has not been assigned to an administrator.',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onAssign,
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: Text(hasAssignment ? 'Reassign' : 'Assign to Admin'),
            style: OutlinedButton.styleFrom(
              foregroundColor: navy,
              side: const BorderSide(color: navy),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons({
    required String status,
    required VoidCallback onStatusChange,
    required VoidCallback? onResolve,
    required VoidCallback onDelete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: onStatusChange,
            icon: const Icon(Icons.sync_rounded),
            label: const Text('Change Status'),
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        if (onResolve != null) ...[
          const SizedBox(height: 10),
          SizedBox(
            height: 48,
            child: OutlinedButton.icon(
              onPressed: onResolve,
              icon: const Icon(Icons.check_circle_outline_rounded),
              label: const Text('Mark as Resolved'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF16A34A),
                side: const BorderSide(color: Color(0xFF16A34A)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 10),
        SizedBox(
          height: 48,
          child: OutlinedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded),
            label: const Text('Delete'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFDC2626),
              side: const BorderSide(color: Color(0xFFDC2626)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: navy,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionText(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey.shade800, fontSize: 14, height: 1.55),
    );
  }

  Widget _priorityBadge(String priority) {
    final normalized = priority.toLowerCase();

    Color color;

    if (normalized == 'urgent') {
      color = const Color(0xFF991B1B);
    } else if (normalized == 'critical') {
      color = const Color(0xFFDC2626);
    } else if (normalized == 'high') {
      color = const Color(0xFFF97316);
    } else if (normalized == 'medium') {
      color = const Color(0xFFF59E0B);
    } else {
      color = const Color(0xFF6B7280);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildNotFound({required String title, required String message}) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text('Details'),
      ),
      body: AdminEmptyState(
        title: title,
        message: message,
        icon: Icons.find_in_page_outlined,
      ),
    );
  }

  IconData _reportIcon(String type) {
    final normalized = type.toLowerCase();

    if (normalized.contains('lawyer')) {
      return Icons.gavel_rounded;
    }

    if (normalized.contains('user')) {
      return Icons.person_outline_rounded;
    }

    if (normalized.contains('payment')) {
      return Icons.payments_outlined;
    }

    if (normalized.contains('case')) {
      return Icons.folder_open_outlined;
    }

    if (normalized.contains('verification')) {
      return Icons.verified_user_outlined;
    }

    if (normalized.contains('appointment')) {
      return Icons.calendar_month_outlined;
    }

    if (normalized.contains('account')) {
      return Icons.manage_accounts_outlined;
    }

    return Icons.report_outlined;
  }

  bool _isFinalStatus(String status) {
    final normalized = status.toLowerCase();

    return normalized == 'resolved' ||
        normalized == 'rejected' ||
        normalized == 'closed';
  }

  void _assignReport(AdminReportModel report) {
    ref
        .read(adminReportsProvider.notifier)
        .assignReport(report.id, 'admin_support', 'Admin Support');

    _showSuccess('Report assigned to Admin Support.');
  }

  void _assignComplaint(ComplaintModel complaint) {
    ref
        .read(adminComplaintsProvider.notifier)
        .assignComplaint(complaint.id, 'admin_support', 'Admin Support');

    _showSuccess('Complaint assigned to Admin Support.');
  }

  void _resolveReport(AdminReportModel report) {
    ref
        .read(adminReportsProvider.notifier)
        .updateReportStatus(
          report.id,
          ReportStatus.resolved.label,
          resolution: 'Resolved by Admin Support.',
        );

    _showSuccess('Report marked as resolved.');
  }

  void _resolveComplaint(ComplaintModel complaint) {
    ref
        .read(adminComplaintsProvider.notifier)
        .updateComplaintStatus(
          complaint.id,
          ReportStatus.resolved.label,
          resolution: 'Resolved by Admin Support.',
        );

    _showSuccess('Complaint marked as resolved.');
  }

  void _deleteReport(AdminReportModel report) {
    _showDeleteConfirmation(
      title: 'Delete Report?',
      message:
          'This will remove "${report.title}" from the admin reports list.',
      onConfirm: () {
        ref.read(adminReportsProvider.notifier).deleteReport(report.id);

        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  void _deleteComplaint(ComplaintModel complaint) {
    _showDeleteConfirmation(
      title: 'Delete Complaint?',
      message:
          'This will remove "${complaint.subject}" from the complaints list.',
      onConfirm: () {
        ref
            .read(adminComplaintsProvider.notifier)
            .deleteComplaint(complaint.id);

        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  void _showReportActions(AdminReportModel report) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bottomSheetHandle(),
                _actionTile(
                  icon: Icons.person_add_alt_1_rounded,
                  title: 'Assign / Reassign',
                  onTap: () {
                    Navigator.pop(context);
                    _assignReport(report);
                  },
                ),
                _actionTile(
                  icon: Icons.sync_rounded,
                  title: 'Change Status',
                  onTap: () {
                    Navigator.pop(context);
                    _showStatusDialog(
                      isReportItem: true,
                      id: report.id,
                      currentStatus: report.status,
                    );
                  },
                ),
                _actionTile(
                  icon: Icons.delete_outline_rounded,
                  title: 'Delete Report',
                  color: const Color(0xFFDC2626),
                  onTap: () {
                    Navigator.pop(context);
                    _deleteReport(report);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showComplaintActions(ComplaintModel complaint) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _bottomSheetHandle(),
                _actionTile(
                  icon: Icons.person_add_alt_1_rounded,
                  title: 'Assign / Reassign',
                  onTap: () {
                    Navigator.pop(context);
                    _assignComplaint(complaint);
                  },
                ),
                _actionTile(
                  icon: Icons.sync_rounded,
                  title: 'Change Status',
                  onTap: () {
                    Navigator.pop(context);
                    _showStatusDialog(
                      isReportItem: false,
                      id: complaint.id,
                      currentStatus: complaint.status,
                    );
                  },
                ),
                _actionTile(
                  icon: Icons.delete_outline_rounded,
                  title: 'Delete Complaint',
                  color: const Color(0xFFDC2626),
                  onTap: () {
                    Navigator.pop(context);
                    _deleteComplaint(complaint);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStatusDialog({
    required bool isReportItem,
    required String id,
    required String currentStatus,
  }) {
    ReportStatus selectedStatus = ReportStatusExtension.fromString(
      currentStatus,
    );

    final resolutionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final requiresResolution =
                selectedStatus == ReportStatus.resolved ||
                selectedStatus == ReportStatus.rejected ||
                selectedStatus == ReportStatus.closed;

            return AlertDialog(
              title: const Text(
                'Change Status',
                style: TextStyle(color: navy, fontWeight: FontWeight.w800),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<ReportStatus>(
                      initialValue: selectedStatus,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: ReportStatus.values.map((status) {
                        return DropdownMenuItem<ReportStatus>(
                          value: status,
                          child: Text(status.label),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          selectedStatus = value;
                        });
                      },
                    ),
                    if (requiresResolution) ...[
                      const SizedBox(height: 14),
                      TextField(
                        controller: resolutionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Resolution / Notes',
                          hintText: 'Enter resolution details...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final resolution = resolutionController.text.trim();

                    if (isReportItem) {
                      ref
                          .read(adminReportsProvider.notifier)
                          .updateReportStatus(
                            id,
                            selectedStatus.label,
                            resolution: resolution.isEmpty ? null : resolution,
                          );
                    } else {
                      ref
                          .read(adminComplaintsProvider.notifier)
                          .updateComplaintStatus(
                            id,
                            selectedStatus.label,
                            resolution: resolution.isEmpty ? null : resolution,
                          );
                    }

                    Navigator.pop(dialogContext);
                    _showSuccess('Status changed to ${selectedStatus.label}.');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      resolutionController.dispose();
    });
  }

  void _showDeleteConfirmation({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: navy, fontWeight: FontWeight.w800),
          ),
          content: Text(message, style: const TextStyle(height: 1.4)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = navy,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
      onTap: onTap,
    );
  }

  Widget _bottomSheetHandle() {
    return Container(
      width: 42,
      height: 4,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  String _formatDateTime(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();

    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final hour = hour12.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$day/$month/$year • $hour:$minute $period';
  }
}

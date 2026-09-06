import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/data/mock/admin_verification_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_document_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_request_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_status_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/providers/verification_details_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/screen/verification_document_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_action_buttons.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_document_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_status_chip.dart';

class VerificationRequestDetailsScreen extends ConsumerWidget {
  final String requestId;

  const VerificationRequestDetailsScreen({
    super.key,
    required this.requestId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verificationState = ref.watch(
      verificationDetailsProvider(requestId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Details'),
      ),
      body: verificationState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Unable to load verification request.\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (request) {
          if (request == null) {
            return const Center(
              child: Text(
                'Verification request not found.',
              ),
            );
          }

          final documents = _documentsForRequest(request.id);

          return _DetailsContent(
            request: request,
            documents: documents,
            onApprove: () {
              ref
                  .read(
                    verificationDetailsProvider(requestId).notifier,
                  )
                  .setStatus(
                    VerificationStatusModel.approved.value,
                    reviewerName: 'Admin',
                    notes: 'Verification approved by administrator.',
                  );

              _showMessage(
                context,
                'Verification request approved.',
              );
            },
            onReject: () {
              _showRejectDialog(
                context,
                ref,
                request,
              );
            },
            onMarkUnderReview: () {
              ref
                  .read(
                    verificationDetailsProvider(requestId).notifier,
                  )
                  .setStatus(
                    VerificationStatusModel.underReview.value,
                    reviewerName: 'Admin',
                    notes: 'Verification is currently under review.',
                  );

              _showMessage(
                context,
                'Verification marked as under review.',
              );
            },
            onViewDocuments: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VerificationDocumentScreen(
                    applicantName: request.applicantName,
                    documents: documents,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<VerificationDocumentModel> _documentsForRequest(
    String verificationRequestId,
  ) {
    final requests = AdminVerificationMockData.requests;

    final requestExists = requests.any(
      (request) => request.id == verificationRequestId,
    );

    if (!requestExists) {
      return [];
    }

    return [
      VerificationDocumentModel(
        id: '${verificationRequestId}_document_001',
        verificationRequestId: verificationRequestId,
        documentType: 'CNIC',
        documentName: 'CNIC / Identity Document',
        documentNumber: '35202-1234567-1',
        documentUrl: 'mock://documents/cnic',
        status: 'approved',
        uploadedAt: DateTime(2026, 8, 28, 10, 35),
      ),
      VerificationDocumentModel(
        id: '${verificationRequestId}_document_002',
        verificationRequestId: verificationRequestId,
        documentType: 'Bar Council Certificate',
        documentName: 'Bar Council Registration Certificate',
        documentNumber: 'BC-2026-00125',
        documentUrl: 'mock://documents/bar-council',
        status: 'pending',
        uploadedAt: DateTime(2026, 8, 28, 10, 38),
      ),
      VerificationDocumentModel(
        id: '${verificationRequestId}_document_003',
        verificationRequestId: verificationRequestId,
        documentType: 'Law Degree',
        documentName: 'LL.B Degree Certificate',
        documentNumber: 'LLB-2021-0456',
        documentUrl: 'mock://documents/degree',
        status: 'pending',
        uploadedAt: DateTime(2026, 8, 28, 10, 42),
      ),
    ];
  }

  void _showRejectDialog(
    BuildContext context,
    WidgetRef ref,
    VerificationRequestModel request,
  ) {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reject Verification'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Rejection reason',
              hintText: 'Enter the reason for rejection...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.dispose();
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final reason = controller.text.trim();

                if (reason.isEmpty) {
                  return;
                }

                ref
                    .read(
                      verificationDetailsProvider(request.id).notifier,
                    )
                    .setStatus(
                      VerificationStatusModel.rejected.value,
                      reviewerName: 'Admin',
                      rejectionReason: reason,
                      notes: 'Verification rejected by administrator.',
                    );

                controller.dispose();
                Navigator.pop(dialogContext);

                _showMessage(
                  context,
                  'Verification request rejected.',
                );
              },
              child: const Text('Reject'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}

class _DetailsContent extends StatelessWidget {
  final VerificationRequestModel request;
  final List<VerificationDocumentModel> documents;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback onMarkUnderReview;
  final VoidCallback onViewDocuments;

  const _DetailsContent({
    required this.request,
    required this.documents,
    required this.onApprove,
    required this.onReject,
    required this.onMarkUnderReview,
    required this.onViewDocuments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ApplicantCard(
          request: request,
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Verification Status',
          icon: Icons.verified_user_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerificationStatusChip(
                status: request.status,
              ),
              if (request.reviewedAt != null) ...[
                const SizedBox(height: 12),
                _InfoRow(
                  label: 'Reviewed',
                  value: _formatDateTime(request.reviewedAt!),
                ),
              ],
              if (request.reviewerName != null) ...[
                const SizedBox(height: 8),
                _InfoRow(
                  label: 'Reviewer',
                  value: request.reviewerName!,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Applicant Information',
          icon: Icons.person_outline_rounded,
          child: Column(
            children: [
              _InfoRow(
                label: 'Applicant ID',
                value: request.applicantId,
              ),
              _InfoRow(
                label: 'Applicant Type',
                value: request.applicantType,
              ),
              _InfoRow(
                label: 'Email',
                value: request.email,
              ),
              _InfoRow(
                label: 'Phone',
                value: request.phone,
              ),
              _InfoRow(
                label: 'Submitted',
                value: _formatDateTime(request.submittedAt),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _SectionCard(
          title: 'Documents',
          icon: Icons.folder_outlined,
          trailing: TextButton(
            onPressed: onViewDocuments,
            child: const Text('View All'),
          ),
          child: documents.isEmpty
              ? const Text('No documents submitted.')
              : Column(
                  children: documents
                      .take(3)
                      .map(
                        (document) => VerificationDocumentCard(
                          document: document,
                        ),
                      )
                      .toList(),
                ),
        ),
        if (request.notes != null && request.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Notes',
            icon: Icons.notes_outlined,
            child: Text(
              request.notes!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
        if (request.rejectionReason != null &&
            request.rejectionReason!.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Rejection Reason',
            icon: Icons.warning_amber_outlined,
            child: Text(
              request.rejectionReason!,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
        VerificationActionButtons(
          onApprove: request.status ==
                  VerificationStatusModel.approved.value
              ? null
              : onApprove,
          onReject: request.status ==
                  VerificationStatusModel.rejected.value
              ? null
              : onReject,
          onMarkUnderReview: request.status ==
                  VerificationStatusModel.underReview.value
              ? null
              : onMarkUnderReview,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}

class _ApplicantCard extends StatelessWidget {
  final VerificationRequestModel request;

  const _ApplicantCard({
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                _initials(request.applicantName),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.applicantName,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    request.applicantType,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first.substring(0, 1)}'
        '${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ?trailing,
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
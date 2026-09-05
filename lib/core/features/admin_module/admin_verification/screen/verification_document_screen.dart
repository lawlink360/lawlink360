import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_document_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/widgets/verification_document_card.dart';

class VerificationDocumentScreen extends StatelessWidget {
  final String applicantName;
  final List<VerificationDocumentModel> documents;

  const VerificationDocumentScreen({
    super.key,
    required this.applicantName,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Documents'),
      ),
      body: documents.isEmpty
          ? const _EmptyDocumentsView()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ApplicantHeader(
                  applicantName: applicantName,
                  documentCount: documents.length,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Submitted Documents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ...documents.map(
                  (document) => VerificationDocumentCard(
                    document: document,
                    onTap: () {
                      _showDocumentDetails(
                        context,
                        document,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void _showDocumentDetails(
    BuildContext context,
    VerificationDocumentModel document,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.documentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _DetailRow(
                  label: 'Document Type',
                  value: document.documentType,
                ),
                _DetailRow(
                  label: 'Document Number',
                  value: document.documentNumber.isEmpty
                      ? 'Not provided'
                      : document.documentNumber,
                ),
                _DetailRow(
                  label: 'Status',
                  value: _formatStatus(document.status),
                ),
                _DetailRow(
                  label: 'Uploaded',
                  value: _formatDate(document.uploadedAt),
                ),
                const SizedBox(height: 12),
                if (document.rejectionReason != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Rejection reason: ${document.rejectionReason}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDocumentPreview(
                        context,
                        document,
                      );
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                    ),
                    label: const Text('View Document'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDocumentPreview(
    BuildContext context,
    VerificationDocumentModel document,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(document.documentName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.description_outlined,
                    size: 64,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Document preview will be connected to secure storage in the backend phase.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _formatStatus(String status) {
    return status
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _ApplicantHeader extends StatelessWidget {
  final String applicantName;
  final int documentCount;

  const _ApplicantHeader({
    required this.applicantName,
    required this.documentCount,
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
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              child: Text(
                _initials(applicantName),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    applicantName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$documentCount document'
                    '${documentCount == 1 ? '' : 's'} submitted',
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
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

class _EmptyDocumentsView extends StatelessWidget {
  const _EmptyDocumentsView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_off_outlined,
              size: 56,
            ),
            SizedBox(height: 12),
            Text(
              'No documents available.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'No verification documents were submitted for this request.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
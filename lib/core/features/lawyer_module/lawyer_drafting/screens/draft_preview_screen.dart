import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/draft_model.dart';
import '../providers/draft_providers.dart';

class DraftPreviewScreen extends ConsumerWidget {
  const DraftPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    final draftId = arguments is String ? arguments : null;

    final draft = draftId == null
        ? null
        : ref.read(draftProvider.notifier).getDraft(draftId);

    if (draft == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: const Color(0xFF13294B),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Draft Preview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'Draft not found.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Draft Preview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Edit Draft',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/drafting/editor',
                arguments: draft.id,
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _PreviewDocument(
            draft: draft,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _PreviewActionButton(
                  icon: Icons.edit_outlined,
                  title: 'Edit',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/drafting/editor',
                      arguments: draft.id,
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PreviewActionButton(
                  icon: Icons.share_outlined,
                  title: 'Share',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Sharing will be connected later.',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'PDF generation will be connected later.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13294B),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(
                Icons.picture_as_pdf_outlined,
              ),
              label: const Text(
                'Generate PDF',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ============================================================
// PREVIEW DOCUMENT
// ============================================================

class _PreviewDocument extends StatelessWidget {
  const _PreviewDocument({
    required this.draft,
  });

  final DraftModel draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        22,
        28,
        22,
        30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==================================================
          // DOCUMENT HEADER
          // ==================================================

          const Center(
            child: Text(
              'LAWLINK360',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Color(0xFF13294B),
              ),
            ),
          ),

          const SizedBox(height: 4),

          const Center(
            child: Text(
              'LEGAL DRAFT',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.5,
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 22),

          const Divider(
            color: Color(0xFFE5E7EB),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // TITLE
          // ==================================================

          Center(
            child: Text(
              draft.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==================================================
          // CASE INFORMATION
          // ==================================================

          if (draft.clientName != null ||
              draft.caseTitle != null ||
              draft.category.isNotEmpty)
            _DocumentInfoBox(
              draft: draft,
            ),

          if (draft.clientName != null ||
              draft.caseTitle != null ||
              draft.category.isNotEmpty)
            const SizedBox(height: 22),

          // ==================================================
          // CONTENT
          // ==================================================

          Text(
            draft.content,
            style: const TextStyle(
              fontSize: 13,
              height: 1.8,
              color: Color(0xFF202938),
            ),
          ),

          const SizedBox(height: 35),

          // ==================================================
          // DATE
          // ==================================================

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Updated: ${_formatDate(draft.updatedAt)}',
              style: const TextStyle(
                fontSize: 9,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// ============================================================
// DOCUMENT INFORMATION
// ============================================================

class _DocumentInfoBox extends StatelessWidget {
  const _DocumentInfoBox({
    required this.draft,
  });

  final DraftModel draft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          if (draft.clientName != null)
            _InfoRow(
              label: 'Client',
              value: draft.clientName!,
            ),

          if (draft.caseTitle != null)
            _InfoRow(
              label: 'Case',
              value: draft.caseTitle!,
            ),

          _InfoRow(
            label: 'Category',
            value: draft.category,
          ),

          _InfoRow(
            label: 'Status',
            value: draft.status,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INFORMATION ROW
// ============================================================

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE5E7EB),
                ),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF13294B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ACTION BUTTON
// ============================================================

class _PreviewActionButton extends StatelessWidget {
  const _PreviewActionButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF13294B),
        backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
        elevation: 0,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      icon: Icon(
        icon,
        size: 19,
      ),
      label: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
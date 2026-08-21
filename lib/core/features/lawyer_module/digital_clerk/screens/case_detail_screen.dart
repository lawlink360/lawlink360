import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/case_model.dart';
import '../providers/clerk_providers.dart';
import 'add_case_screen.dart';

class CaseDetailsScreen extends ConsumerWidget {
  const CaseDetailsScreen({
    super.key,
    required this.caseItem,
  });

  final CaseModel caseItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cases = ref.watch(clerkCasesProvider);

    final currentCase = cases.cast<CaseModel?>().firstWhere(
          (item) => item?.id == caseItem.id,
          orElse: () => null,
        );

    if (currentCase == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: const Color(0xFF13294B),
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Case Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'Case not found.',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontSize: 15,
              fontWeight: FontWeight.w600,
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
        title: const Text(
          'Case Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderCard(caseItem: currentCase),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Case Information',
              icon: Icons.folder_outlined,
              children: [
                _DetailRow(
                  label: 'Case Title',
                  value: currentCase.caseTitle,
                ),
                if (currentCase.caseNumber.isNotEmpty)
                  _DetailRow(
                    label: 'Case Number',
                    value: currentCase.caseNumber,
                  ),
                _DetailRow(
                  label: 'Case Type',
                  value: currentCase.caseType,
                ),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Parties & Court',
              icon: Icons.people_outline,
              children: [
                _DetailRow(
                  label: 'Client',
                  value: currentCase.clientName,
                ),
                _DetailRow(
                  label: 'Opposite Party',
                  value: currentCase.oppositeParty,
                ),
                _DetailRow(
                  label: 'Judge',
                  value: currentCase.judgeName,
                ),
                if (currentCase.courtName.isNotEmpty)
                  _DetailRow(
                    label: 'Court',
                    value: currentCase.courtName,
                  ),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Next Hearing',
              icon: Icons.event_outlined,
              children: [
                _DetailRow(
                  label: 'Date',
                  value: _formatDate(
                    currentCase.nextHearingDate,
                  ),
                ),
                if (currentCase.hearingTime != null &&
                    currentCase.hearingTime!.isNotEmpty)
                  _DetailRow(
                    label: 'Time',
                    value: currentCase.hearingTime!,
                  ),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Case Notes',
              icon: Icons.notes_outlined,
              children: [
                Text(
                  currentCase.notes.isEmpty
                      ? 'No notes added.'
                      : currentCase.notes,
                  style: TextStyle(
                    color: currentCase.notes.isEmpty
                        ? Colors.grey.shade500
                        : const Color(0xFF13294B),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddCaseScreen(
                            caseToEdit: currentCase,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                    ),
                    label: const Text('Edit Case'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFF13294B),
                      side: const BorderSide(
                        color: Color(0xFF13294B),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final shouldDelete =
                          await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: const Text(
                              'Delete Case?',
                              style: TextStyle(
                                color: Color(0xFF13294B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'Are you sure you want to delete '
                              'this case? This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    dialogContext,
                                    false,
                                  );
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Color(0xFF13294B),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    dialogContext,
                                    true,
                                  );
                                },
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFFD32F2F),
                                  foregroundColor:
                                      Colors.white,
                                  elevation: 0,
                                ),
                                child:
                                    const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldDelete != true) {
                        return;
                      }

                      ref
                          .read(
                            clerkCasesProvider.notifier,
                          )
                          .deleteCase(currentCase.id);

                      if (context.mounted) {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Case deleted successfully.',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD32F2F),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Not provided';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// ======================================================
// HEADER CARD
// ======================================================

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.caseItem,
  });

  final CaseModel caseItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF13294B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.gavel_rounded,
              color: Color(0xFFD4AF37),
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  caseItem.caseTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${caseItem.clientName} vs. '
                  '${caseItem.oppositeParty}',
                  style: TextStyle(
                    color: Colors.white
                        .withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          _StatusBadge(
            status: caseItem.status,
          ),
        ],
      ),
    );
  }
}

// ======================================================
// SECTION CARD
// ======================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF13294B),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
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
}

// ======================================================
// DETAIL ROW
// ======================================================

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF13294B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// STATUS BADGE
// ======================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _statusColor() {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF66BB6A);

      case 'pending':
        return const Color(0xFFFFB74D);

      case 'closed':
      case 'disposed':
        return Colors.grey;

      case 'on hold':
        return const Color(0xFFB39DDB);

      default:
        return const Color(0xFFD4AF37);
    }
  }
}
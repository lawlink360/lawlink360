import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/clerk_providers.dart';
import 'case_detail_screen.dart';

class AllCasesScreen extends ConsumerWidget {
  const AllCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cases = ref.watch(clerkCasesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        title: const Text(
          'All Cases',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: cases.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.folder_open_outlined,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No cases added yet',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cases.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final caseItem = cases[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CaseDetailsScreen(caseItem: caseItem),
                      ),
                    );
                  },
                  child: _CaseCard(
                    caseTitle: caseItem.caseTitle,
                    caseNumber: caseItem.caseNumber,
                    clientName: caseItem.clientName,
                    oppositeParty: caseItem.oppositeParty,
                    judgeName: caseItem.judgeName,
                    hearingDate: caseItem.nextHearingDate,
                    hearingTime: caseItem.hearingTime,
                    status: caseItem.status,
                  ),
                );
              },
            ),
    );
  }
}

class _CaseCard extends StatelessWidget {
  const _CaseCard({
    required this.caseTitle,
    required this.caseNumber,
    required this.clientName,
    required this.oppositeParty,
    required this.judgeName,
    required this.hearingDate,
    required this.hearingTime,
    required this.status,
  });

  final String caseTitle;
  final String caseNumber;
  final String clientName;
  final String oppositeParty;
  final String judgeName;
  final DateTime? hearingDate;
  final String? hearingTime;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  caseTitle,
                  style: const TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _StatusBadge(status: status),
            ],
          ),

          const SizedBox(height: 6),

          if (caseNumber.isNotEmpty)
            Text(
              caseNumber,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),

          const SizedBox(height: 12),

          _InfoRow(
            icon: Icons.person_outline,
            label: 'Client',
            value: clientName,
          ),

          const SizedBox(height: 7),

          _InfoRow(
            icon: Icons.people_outline,
            label: 'Opposite Party',
            value: oppositeParty,
          ),

          const SizedBox(height: 7),

          _InfoRow(
            icon: Icons.gavel_outlined,
            label: 'Judge',
            value: judgeName,
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.event_outlined,
                  size: 18,
                  color: Color(0xFFD4AF37),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _hearingText(),
                    style: const TextStyle(
                      color: Color(0xFF13294B),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _hearingText() {
    if (hearingDate == null) {
      return 'Hearing date not set';
    }

    final date =
        '${hearingDate!.day.toString().padLeft(2, '0')}/'
        '${hearingDate!.month.toString().padLeft(2, '0')}/'
        '${hearingDate!.year}';

    if (hearingTime == null || hearingTime!.isEmpty) {
      return 'Hearing: $date';
    }

    return 'Hearing: $date • $hearingTime';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF13294B)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF13294B),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
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
        return const Color(0xFF2E7D32);
      case 'pending':
        return const Color(0xFFEF8C00);
      case 'closed':
      case 'disposed':
        return Colors.grey;
      case 'on hold':
        return const Color(0xFF7B61A8);
      default:
        return const Color(0xFF13294B);
    }
  }
}

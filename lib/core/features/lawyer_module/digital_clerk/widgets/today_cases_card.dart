import 'package:flutter/material.dart';
import '../screens/all_cases_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/clerk_providers.dart';

class TodayCasesCard extends ConsumerWidget {
  const TodayCasesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCases = ref.watch(clerkCasesProvider);

final now = DateTime.now();

final todayCases = allCases.where((caseItem) {
  final hearingDate = caseItem.nextHearingDate;

  if (hearingDate == null) {
    return false;
  }

  return hearingDate.year == now.year &&
      hearingDate.month == now.month &&
      hearingDate.day == now.day;
}).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Today's Cases",
                  style: TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AllCasesScreen(),
      ),
    );
  },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFFD4AF37),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // =====================================================
          // NO CASES
          // =====================================================

          if (todayCases.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE6EAF0),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_note_outlined,
                    size: 42,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No cases added yet',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Add a case from Quick Actions.',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

          // =====================================================
          // SAVED CASES
          // =====================================================

         if (todayCases.isNotEmpty)
            ...todayCases.map(
              (caseItem) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _CaseItem(
                    caseNumber: caseItem.caseNumber.isEmpty
                        ? 'Case Number not added'
                        : caseItem.caseNumber,
                    title: caseItem.caseTitle,
                    clientName: caseItem.clientName,
                    oppositeParty: caseItem.oppositeParty,
                    judgeName: caseItem.judgeName,
                    time: caseItem.hearingTime ?? 'Time not set',
                    status: caseItem.status,
                    statusColor: _statusColor(caseItem.status),
                    icon: Icons.gavel_rounded,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
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

// ======================================================
// CASE ITEM
// ======================================================

class _CaseItem extends StatelessWidget {
  const _CaseItem({
    required this.caseNumber,
    required this.title,
    required this.clientName,
    required this.oppositeParty,
    required this.judgeName,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.icon,
  });

  final String caseNumber;
  final String title;
  final String clientName;
  final String oppositeParty;
  final String judgeName;
  final String time;
  final String status;
  final Color statusColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE6EAF0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF13294B).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF13294B),
              size: 23,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caseNumber,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '$clientName vs. $oppositeParty',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Judge: $judgeName',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
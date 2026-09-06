import 'package:flutter/material.dart';

import '../models/client_case_summary_model.dart';
import '../models/lawyer_client_model.dart';

class ClientCasesScreen extends StatelessWidget {
  final LawyerClientModel client;
  final List<ClientCaseSummaryModel> cases;

  const ClientCasesScreen({
    super.key,
    required this.client,
    required this.cases,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0D1B2A);
    const gold = Color(0xFFD4AF37);
    const background = Color(0xFFF5F7FB);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: navy,
        centerTitle: true,
        title: const Text(
          'Client Cases',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: navy,
          ),
        ),
      ),
      body: SafeArea(
        child: cases.isEmpty
            ? _EmptyCasesState(clientName: client.name)
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                children: [
                  _ClientHeaderCard(
                    client: client,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      const Icon(
                        Icons.folder_open_outlined,
                        color: gold,
                        size: 23,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        '${cases.length} Case${cases.length == 1 ? '' : 's'}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  ...cases.map(
                    (caseItem) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _CaseCard(
                        caseItem: caseItem,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ============================================================
// CLIENT HEADER
// ============================================================

class _ClientHeaderCard extends StatelessWidget {
  final LawyerClientModel client;

  const _ClientHeaderCard({
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0D1B2A);
    const gold = Color(0xFFD4AF37);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          _ClientAvatar(
            imageUrl: client.imageUrl,
            name: client.name,
            size: 64,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: gold,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        client.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${client.activeCases} active • ${client.totalCases} total',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CASE CARD
// ============================================================

class _CaseCard extends StatelessWidget {
  final ClientCaseSummaryModel caseItem;

  const _CaseCard({
    required this.caseItem,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0D1B2A);
    const gold = Color(0xFFD4AF37);

    final statusColor = _statusColor(caseItem.status);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withValues(alpha:0.04),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.035),
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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: gold.withValues(alpha:0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.gavel_outlined,
                  color: gold,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caseItem.caseTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Case No. ${caseItem.caseNumber}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              _StatusBadge(
                status: caseItem.status,
                color: statusColor,
              ),
            ],
          ),

          const SizedBox(height: 18),

          _CaseInfoRow(
            icon: Icons.account_balance_outlined,
            label: 'Court',
            value: caseItem.court,
          ),

          const SizedBox(height: 10),

          _CaseInfoRow(
            icon: Icons.category_outlined,
            label: 'Case Type',
            value: caseItem.caseType,
          ),

          if (caseItem.nextHearingDate != null) ...[
            const SizedBox(height: 10),
            _CaseInfoRow(
              icon: Icons.calendar_month_outlined,
              label: 'Next Hearing',
              value: _formatDate(caseItem.nextHearingDate!),
            ),
          ],

          if (caseItem.lastUpdate != null &&
              caseItem.lastUpdate!.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            _CaseInfoRow(
              icon: Icons.update_outlined,
              label: 'Last Update',
              value: caseItem.lastUpdate!,
            ),
          ],

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Case details will be connected in the next step.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
              ),
              label: const Text(
                'View Case Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: navy,
                side: const BorderSide(
                  color: gold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Color _statusColor(String status) {
    final value = status.toLowerCase();

    if (value.contains('active') ||
        value.contains('pending')) {
      return Colors.orange;
    }

    if (value.contains('won') ||
        value.contains('disposed') ||
        value.contains('closed')) {
      return Colors.green;
    }

    if (value.contains('dismiss')) {
      return Colors.red;
    }

    return Colors.blueGrey;
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// ============================================================
// CASE INFO ROW
// ============================================================

class _CaseInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CaseInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0D1B2A);
    const gold = Color(0xFFD4AF37);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: gold,
        ),
        const SizedBox(width: 9),
        SizedBox(
          width: 82,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: navy,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  final String status;
  final Color color;

  const _StatusBadge({
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ============================================================
// CLIENT AVATAR
// ============================================================

class _ClientAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;

  const _ClientAvatar({
    required this.imageUrl,
    required this.name,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return _fallbackAvatar();
                },
              )
            : _fallbackAvatar(),
      ),
    );
  }

  Widget _fallbackAvatar() {
    return Container(
      color: const Color(0xFFF5F7FB),
      alignment: Alignment.center,
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Color(0xFF0D1B2A),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class _EmptyCasesState extends StatelessWidget {
  final String clientName;

  const _EmptyCasesState({
    required this.clientName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withValues(alpha:0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_off_outlined,
                color: Color(0xFFD4AF37),
                size: 40,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Cases Yet',
              style: TextStyle(
                color: Color(0xFF0D1B2A),
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '$clientName does not have any cases linked to your account yet.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
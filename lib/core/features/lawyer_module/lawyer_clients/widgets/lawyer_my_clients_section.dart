import 'package:flutter/material.dart';
import '../screens/my_clients_screen.dart';

class LawyerMyClientsSection extends StatelessWidget {
  const LawyerMyClientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------
        // SECTION HEADER
        // --------------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'My Clients',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyClientsScreen()),
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

        const SizedBox(height: 12),

        // --------------------------------------------------
        // CLIENTS
        // --------------------------------------------------
        _ClientListCard(
          name: 'Muhammad Ahmed',
          caseTitle: 'Property Dispute',
          caseStatus: 'Active Case',
          initials: 'MA',
          statusColor: Colors.green,
        ),

        const SizedBox(height: 12),

        _ClientListCard(
          name: 'Ayesha Khan',
          caseTitle: 'Family Matter',
          caseStatus: 'Active Case',
          initials: 'AK',
          statusColor: Colors.green,
        ),

        const SizedBox(height: 12),

        _ClientListCard(
          name: 'Ali Raza',
          caseTitle: 'Civil Suit',
          caseStatus: 'Case Closed',
          initials: 'AR',
          statusColor: Colors.grey,
        ),
      ],
    );
  }
}

// ============================================================
// CLIENT CARD
// ============================================================

class _ClientListCard extends StatelessWidget {
  final String name;
  final String caseTitle;
  final String caseStatus;
  final String initials;
  final Color statusColor;

  const _ClientListCard({
    required this.name,
    required this.caseTitle,
    required this.caseStatus,
    required this.initials,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // Client profile navigation will be connected later.
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // --------------------------------------------------
              // AVATAR
              // --------------------------------------------------
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8E1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Color(0xFF13294B),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 13),

              // --------------------------------------------------
              // CLIENT INFORMATION
              // --------------------------------------------------
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF13294B),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      caseTitle,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12.5,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          caseStatus,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // --------------------------------------------------
              // ARROW
              // --------------------------------------------------
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFFD4AF37),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

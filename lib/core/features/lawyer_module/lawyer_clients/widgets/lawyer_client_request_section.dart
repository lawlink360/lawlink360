import 'package:flutter/material.dart';
import '../screens/client_requests_screen.dart';

class LawyerClientRequestSection extends StatelessWidget {
  const LawyerClientRequestSection({super.key});

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
              'Client Requests',
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
                  MaterialPageRoute(
                    builder: (_) => const ClientRequestsScreen(),
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

        const SizedBox(height: 12),

        // --------------------------------------------------
        // REQUEST CARD
        // --------------------------------------------------
        _ClientRequestCard(
          name: 'Muhammad Ahmed',
          requestType: 'Legal Consultation',
          date: 'Today • 11:30 AM',
          initials: 'MA',
        ),

        const SizedBox(height: 12),

        _ClientRequestCard(
          name: 'Ayesha Khan',
          requestType: 'Property Case',
          date: 'Tomorrow • 02:00 PM',
          initials: 'AK',
        ),
      ],
    );
  }
}

// ============================================================
// CLIENT REQUEST CARD
// ============================================================

class _ClientRequestCard extends StatelessWidget {
  final String name;
  final String requestType;
  final String date;
  final String initials;

  const _ClientRequestCard({
    required this.name,
    required this.requestType,
    required this.date,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // --------------------------------------------------
          // CLIENT INFORMATION
          // --------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF8E1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Color(0xFF13294B),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

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
                      requestType,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.5,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons.schedule_outlined,
                          size: 14,
                          color: Color(0xFFD4AF37),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            date,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Pending',
                  style: TextStyle(
                    color: Color(0xFF8A6D1D),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // --------------------------------------------------
          // ACTIONS
          // --------------------------------------------------
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Decline request logic will be connected later.
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF64748B),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                  child: const Text(
                    'Decline',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Accept request logic will be connected later.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                  child: const Text(
                    'Accept',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

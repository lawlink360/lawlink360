
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/lawyer_clients_provider.dart';
import '../models/client_case_summary_model.dart';
import 'client_cases_screen.dart';

class ClientProfileScreen extends ConsumerWidget {
  final String clientId;

  const ClientProfileScreen({
    super.key,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref
        .read(lawyerClientsProvider.notifier)
        .getClientById(clientId);

    if (client == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FB),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Client Profile',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'Client not found.',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontSize: 15,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Client Profile',
          style: TextStyle(
            color: Color(0xFF13294B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            20,
            18,
            20,
            40,
          ),

          children: [
            // ==================================================
            // PROFILE HEADER
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: const Color(0xFF13294B),
                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                children: [
                  Container(
                    width: 82,
                    height: 82,

                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFD4AF37),
                        width: 2,
                      ),
                    ),

                    child: const Icon(
                      Icons.person_rounded,
                      size: 42,
                      color: Color(0xFFD4AF37),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    client.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white70,
                        size: 16,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        client.city,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // CHAT / CALL / VIDEO CALL
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: _CommunicationButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Chat',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Opening chat with ${client.name}',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _CommunicationButton(
                    icon: Icons.call_outlined,
                    label: 'Call',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Calling ${client.name}',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _CommunicationButton(
                    icon: Icons.videocam_outlined,
                    label: 'Video',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Starting video call with ${client.name}',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ==================================================
            // CONTACT INFORMATION
            // ==================================================

            _SectionCard(
              title: 'Contact Information',
              icon: Icons.contact_phone_outlined,
              children: [
                _InfoRow(
                  label: 'Phone',
                  value: client.phone,
                ),

                _InfoRow(
                  label: 'Email',
                  value: client.email,
                ),

                _InfoRow(
                  label: 'City',
                  value: client.city,
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================
            // CASE SUMMARY
            // ==================================================

            _SectionCard(
              title: 'Case Summary',
              icon: Icons.gavel_outlined,
              children: [
                _InfoRow(
                  label: 'Current Case',
                  value: client.caseTitle,
                ),

                _InfoRow(
                  label: 'Case Status',
                  value: client.caseStatus,
                ),

                _InfoRow(
                  label: 'Active Cases',
                  value: client.activeCases.toString(),
                ),

                _InfoRow(
                  label: 'Total Cases',
                  value: client.totalCases.toString(),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ==================================================
            // ACTIONS
            // ==================================================

            const Text(
              'Client Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 12),

            // --------------------------------------------------
            // VIEW CASES
            // --------------------------------------------------

            _ActionButton(
              icon: Icons.folder_open_outlined,
              title: 'View Cases',
              subtitle:
                  'View cases and case-related information.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ClientCasesScreen(
                      client: client,
                      cases: [
                        ClientCaseSummaryModel(
                          caseId: 'CASE-001',
                          clientId: client.id,
                          caseTitle: client.caseTitle,
                          caseNumber: 'CIV-2026-001',
                          court: 'Lahore High Court',
                          caseType: 'Civil',
                          status: client.caseStatus,
                          nextHearingDate:
                              DateTime(2026, 8, 25),
                          lastUpdate:
                              'Case documents submitted',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // --------------------------------------------------
            // MESSAGE CLIENT
            // --------------------------------------------------

            _ActionButton(
              icon: Icons.chat_bubble_outline,
              title: 'Message Client',
              subtitle:
                  'Open your conversation with this client.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Client chat will be connected later.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),

            const SizedBox(height: 10),

            // --------------------------------------------------
            // ACTIVITY
            // --------------------------------------------------

            _ActionButton(
              icon: Icons.history_rounded,
              title: 'Activity',
              subtitle:
                  'View recent activity related to this client.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Client activity will be connected later.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COMMUNICATION BUTTON
// ============================================================

class _CommunicationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CommunicationButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),

        child: Container(
          height: 58,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFD4AF37),
              width: 1,
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                icon,
                color: const Color(0xFF13294B),
                size: 21,
              ),

              const SizedBox(height: 4),

              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SECTION CARD
// ============================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFD4AF37),
                size: 22,
              ),

              const SizedBox(width: 9),

              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 17,
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

// ============================================================
// INFO ROW
// ============================================================

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
      padding: const EdgeInsets.only(bottom: 12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF13294B),
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
          ),

          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Icon(
                  icon,
                  color: const Color(0xFFD4AF37),
                  size: 23,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF13294B),
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Color(0xFFD4AF37),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

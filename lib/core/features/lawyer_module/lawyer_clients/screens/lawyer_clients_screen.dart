import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/lawyer_clients_header.dart';
import '../widgets/lawyer_clients_overview_card.dart';
import '../widgets/lawyer_clients_search_bar.dart';
import '../widgets/lawyer_online_client_badge.dart';
import '../widgets/lawyer_client_post_card.dart';
import '../widgets/lawyer_my_clients_section.dart';

import 'package:lawlink360/core/features/lawyer_module/appointments/screens/lawyer_appointment_screen.dart';

class LawyerClientsScreen extends ConsumerWidget {
  const LawyerClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep the provider active for the Lawyer Client home screen.

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // ============================================================
      // APP BAR
      // ============================================================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Lawyer Client',
          style: TextStyle(
            color: Color(0xFF13294B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),

          children: [
            // ======================================================
            // HEADER
            // ======================================================
            const LawyerClientsHeader(),

            const SizedBox(height: 18),

            // ======================================================
            // CLIENT OVERVIEW
            // ======================================================
            const LawyerClientsOverviewCard(),

            const SizedBox(height: 10),

            // ======================================================
            // ONLINE CLIENTS
            // ======================================================
            const LawyerOnlineClientsBadge(onlineClients: 8),

            const SizedBox(height: 22),

            // ======================================================
            // SEARCH
            // ======================================================
            const LawyerClientsSearchBar(),

            const SizedBox(height: 24),

            // ======================================================
            // NEXT APPOINTMENT
            // ======================================================
            const Text(
              'Next Appointment',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _NextAppointmentCard(
              onViewAppointments: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LawyerAppointmentsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // ======================================================
            // MY CLIENTS
            // ======================================================
            const LawyerMyClientsSection(),

            const SizedBox(height: 24),

            // ======================================================
            // CLIENT QUERIES / POSTS
            // ======================================================
            const LawyerClientPostCard(),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// NEXT APPOINTMENT CARD
// ==================================================================

class _NextAppointmentCard extends StatelessWidget {
  final VoidCallback onViewAppointments;

  const _NextAppointmentCard({required this.onViewAppointments});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: const Color(0xFFE5E7EB)),

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
          // ==========================================================
          // APPOINTMENT DETAILS
          // ==========================================================
          Row(
            children: [
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFFD4AF37),
                  size: 26,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Muhammad Ahmed',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF13294B),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Legal Consultation',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12.5,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Today • 11:00 AM',
                      style: TextStyle(
                        color: Color(0xFF218739),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),

                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7EE),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  'Upcoming',
                  style: TextStyle(
                    color: Color(0xFF218739),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ==========================================================
          // VIEW APPOINTMENTS BUTTON
          // ==========================================================
          SizedBox(
            width: double.infinity,

            child: OutlinedButton.icon(
              onPressed: onViewAppointments,

              icon: const Icon(Icons.calendar_today_outlined, size: 17),

              label: const Text(
                'View Appointments',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),

              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF13294B),

                side: const BorderSide(color: Color(0xFFD4AF37)),

                minimumSize: const Size(0, 44),

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
}

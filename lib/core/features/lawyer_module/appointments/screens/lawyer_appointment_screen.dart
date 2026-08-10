import 'package:flutter/material.dart';

class LawyerAppointmentsScreen extends StatelessWidget {
  const LawyerAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Appointments',
          style: TextStyle(
            color: Color(0xFF13294B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==============================
            // HEADER
            // ==============================
            const Text(
              'Manage Your Appointments',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'View and manage your client consultations and meetings.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // ==============================
            // SUMMARY CARDS
            // ==============================
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.calendar_today_outlined,
                    title: 'Upcoming',
                    value: '0',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.pending_actions_outlined,
                    title: 'Pending',
                    value: '0',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.check_circle_outline,
                    title: 'Completed',
                    value: '0',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    icon: Icons.cancel_outlined,
                    title: 'Cancelled',
                    value: '0',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ==============================
            // UPCOMING APPOINTMENTS
            // ==============================
            const Text(
              'Upcoming Appointments',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _EmptyAppointmentCard(
              icon: Icons.event_available_outlined,
              title: 'No Upcoming Appointments',
              description:
                  'Your upcoming client appointments will appear here.',
            ),

            const SizedBox(height: 30),

            // ==============================
            // PENDING APPOINTMENTS
            // ==============================
            const Text(
              'Pending Requests',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _EmptyAppointmentCard(
              icon: Icons.pending_actions_outlined,
              title: 'No Pending Requests',
              description:
                  'New appointment requests from clients will appear here.',
            ),

            const SizedBox(height: 30),

            // ==============================
            // COMPLETED
            // ==============================
            const Text(
              'Recent Completed Appointments',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _EmptyAppointmentCard(
              icon: Icons.history_rounded,
              title: 'No Completed Appointments',
              description:
                  'Your completed consultations will appear here.',
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// SUMMARY CARD
// ======================================================

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFD4AF37),
              size: 22,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF13294B),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// EMPTY APPOINTMENT CARD
// ======================================================

class _EmptyAppointmentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _EmptyAppointmentCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 30,
              color: Color(0xFFD4AF37),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF13294B),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
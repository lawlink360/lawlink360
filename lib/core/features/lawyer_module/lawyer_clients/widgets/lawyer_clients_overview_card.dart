import 'package:flutter/material.dart';

class LawyerClientsOverviewCard extends StatelessWidget {
  const LawyerClientsOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF13294B),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------
          // TITLE
          // --------------------------------------------------

          const Row(
            children: [
              Icon(
                Icons.people_alt_outlined,
                color: Color(0xFFD4AF37),
                size: 23,
              ),
              SizedBox(width: 9),
              Text(
                'Client Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // --------------------------------------------------
          // STATISTICS
          // --------------------------------------------------

          Row(
            children: [
              Expanded(
                child: _OverviewItem(
                  value: '24',
                  label: 'Total Clients',
                  icon: Icons.people_outline,
                ),
              ),

              _divider(),

              Expanded(
                child: _OverviewItem(
                  value: '12',
                  label: 'Active Cases',
                  icon: Icons.gavel_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _OverviewItem(
                  value: '5',
                  label: 'Pending Requests',
                  icon: Icons.pending_actions_outlined,
                ),
              ),

              _divider(),

              Expanded(
                child: _OverviewItem(
                  value: '18',
                  label: 'Completed Cases',
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 58,
      color: Colors.white.withOpacity(0.15),
    );
  }
}

// ============================================================
// OVERVIEW ITEM
// ============================================================

class _OverviewItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _OverviewItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFD4AF37),
              size: 19,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10.5,
                    height: 1.2,
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
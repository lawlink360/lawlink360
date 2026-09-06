import 'package:flutter/material.dart';

class LawyerClientCaseSummary extends StatelessWidget {
  const LawyerClientCaseSummary({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Case Overview',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13294B),
                ),
              ),
              TextButton(
                onPressed: () {},
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

          Row(
            children: const [
              Expanded(
                child: _CaseStat(
                  value: '08',
                  label: 'Active',
                  icon: Icons.folder_open_rounded,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _CaseStat(
                  value: '03',
                  label: 'Upcoming',
                  icon: Icons.event_note_rounded,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _CaseStat(
                  value: '12',
                  label: 'Total',
                  icon: Icons.folder_copy_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CaseStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _CaseStat({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFFD4AF37),
            size: 24,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class RecentServices extends StatelessWidget {
  const RecentServices({super.key});

  @override
  Widget build(BuildContext context) {
    final recentServices = [
      {
        'title': 'High Court Tracking',
        'subtitle': 'Lahore High Court',
        'icon': Icons.account_balance_rounded,
        'color': Colors.indigo,
      },
      {
        'title': 'Lawyer Verification',
        'subtitle': 'Punjab Bar Council',
        'icon': Icons.gavel_rounded,
        'color': Colors.blue,
      },
      {
        'title': 'Land Record',
        'subtitle': 'Punjab Land Records',
        'icon': Icons.home_work_rounded,
        'color': Colors.green,
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recently Used',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 16),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentServices.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final service = recentServices[index];

              return Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          (service['color'] as Color).withOpacity(0.12),
                      child: Icon(
                        service['icon'] as IconData,
                        color: service['color'] as Color,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service['subtitle'] as String,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
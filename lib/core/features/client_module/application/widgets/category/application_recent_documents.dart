import 'package:flutter/material.dart';

class ApplicationRecentDocuments extends StatelessWidget {
  const ApplicationRecentDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    final recentDocuments = [
      {
        'title': 'Leave Application',
        'subtitle': 'Applications & Requests',
        'icon': Icons.description_rounded,
        'color': Colors.blue,
      },
      {
        'title': 'FIR Request',
        'subtitle': 'Government Applications',
        'icon': Icons.local_police_rounded,
        'color': Colors.indigo,
      },
      {
        'title': 'Rent Agreement',
        'subtitle': 'Contracts & Agreements',
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
            'Recent Documents',
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
            itemCount: recentDocuments.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final document = recentDocuments[index];

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
                      color: Colors.black.withValues(alpha:0.05),
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
                          (document['color'] as Color).withValues(alpha:0.12),
                      child: Icon(
                        document['icon'] as IconData,
                        color: document['color'] as Color,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF0F172A),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            document['subtitle'] as String,
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
import 'package:flutter/material.dart';

class LawyerOnlineClientsBadge extends StatelessWidget {
  final int onlineClients;

  const LawyerOnlineClientsBadge({
    super.key,
    required this.onlineClients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // ONLINE INDICATOR
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF22C55E),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 9),

          const Expanded(
            child: Text(
              'Clients Online Now',
              style: TextStyle(
                color: Color(0xFF13294B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // ONLINE COUNT
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7EE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$onlineClients Online',
              style: const TextStyle(
                color: Color(0xFF218739),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CaseCard extends StatelessWidget {
  final String title;
  final String status;
  final String hearingDate;
  final double progress;
  final VoidCallback onTap;

  const CaseCard({
    super.key,
    required this.title,
    required this.status,
    required this.hearingDate,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF10233F),
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            "Next Hearing",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            hearingDate,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF10233F),
            ),
          ),

          const Spacer(),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFFD4AF37),
            ),
          ),

          const SizedBox(height: 14),

          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 18,
              backgroundColor:
                  const Color(0xFFD4AF37).withValues(alpha: 0.15),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFFD4AF37),
                  size: 20,
                ),
                onPressed: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
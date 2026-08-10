import 'package:flutter/material.dart';

class LawyerRatingSummaryCard extends StatelessWidget {
  const LawyerRatingSummaryCard({super.key});

  Widget ratingBar(int stars, double value) {
    return Row(
      children: [
        SizedBox(
          width: 18,
          child: Text(
            "$stars",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const Icon(
          Icons.star,
          size: 16,
          color: Color(0xFFD4AF37),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFFD4AF37),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Client Ratings",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "4.9",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFFD4AF37),
            ),
          ),

          const SizedBox(height: 6),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star,color: Color(0xFFD4AF37)),
              Icon(Icons.star,color: Color(0xFFD4AF37)),
              Icon(Icons.star,color: Color(0xFFD4AF37)),
              Icon(Icons.star,color: Color(0xFFD4AF37)),
              Icon(Icons.star,color: Color(0xFFD4AF37)),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            "Based on 428 verified client reviews",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 26),

          ratingBar(5, .94),

          const SizedBox(height: 12),

          ratingBar(4, .75),

          const SizedBox(height: 12),

          ratingBar(3, .20),

          const SizedBox(height: 12),

          ratingBar(2, .08),

          const SizedBox(height: 12),

          ratingBar(1, .03),
        ],
      ),
    );
  }
}
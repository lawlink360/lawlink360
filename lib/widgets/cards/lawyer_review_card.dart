import 'package:flutter/material.dart';

class LawyerReviewCard extends StatelessWidget {
  const LawyerReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Client Reviews",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 20),

          _review(
            "Muhammad Ali",
            "Excellent lawyer. Very professional and handled my criminal case successfully.",
            "5.0",
          ),

          const Divider(height: 35),

          _review(
            "Ayesha Khan",
            "Highly recommended. Very responsive and guided me throughout the legal process.",
            "4.9",
          ),
        ],
      ),
    );
  }

  static Widget _review(
      String name,
      String review,
      String rating,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFD4AF37),
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color: Color(0xFFD4AF37),
                        size: 16,
                      ),

                      const SizedBox(width: 4),

                      Text(rating),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                review,
                style: const TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class LawyerReviewsCard extends StatelessWidget {
  const LawyerReviewsCard({super.key});

  Widget reviewTile({
    required String name,
    required String review,
    required String date,
    required double rating,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Row(
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
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 18,
                      color: index < rating
                          ? const Color(0xFFD4AF37)
                          : Colors.grey.shade300,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  review,
                  style: const TextStyle(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
            color: Colors.black.withValues(alpha:.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
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

          const SizedBox(height: 22),

          reviewTile(
            name: "Ali Raza",
            rating: 5,
            date: "2 days ago",
            review:
                "Excellent lawyer. Very professional and guided me throughout my criminal case. Highly recommended.",
          ),

          reviewTile(
            name: "Sara Khan",
            rating: 5,
            date: "1 week ago",
            review:
                "Very cooperative, honest and responsive. My family matter was handled professionally.",
          ),

          reviewTile(
            name: "Usman Malik",
            rating: 4,
            date: "3 weeks ago",
            review:
                "Professional consultation and timely communication. Overall a very good experience.",
          ),
        ],
      ),
    );
  }
}
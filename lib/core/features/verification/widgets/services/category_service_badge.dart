import 'package:flutter/material.dart';

class CategoryServiceBadge extends StatelessWidget {
  final bool isOfficial;
  final bool isPopular;

  const CategoryServiceBadge({
    super.key,
    this.isOfficial = true,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        if (isOfficial)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: Colors.green,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  "Official",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

        if (isPopular)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.orange,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  "Popular",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
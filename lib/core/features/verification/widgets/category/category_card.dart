import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int serviceCount;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.serviceCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.12),
                child: Icon(
                  icon,
                  color: color,
                  size: 26,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Icon(
                    Icons.verified_outlined,
                    size: 18,
                    color: color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$serviceCount Services',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
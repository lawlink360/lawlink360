import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: color.withOpacity(0.10),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              /// Icon
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              /// Title & Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// Arrow Button
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
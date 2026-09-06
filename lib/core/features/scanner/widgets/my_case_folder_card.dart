import 'package:flutter/material.dart';

class MyCaseFolderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int documents;
  final VoidCallback onTap;

  const MyCaseFolderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.documents,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [

            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withValues(alpha:.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.folder,
                color: Color(0xFFD4AF37),
                size: 38,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "$documents Documents",
                    style: const TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
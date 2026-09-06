import 'package:flutter/material.dart';

class ScannerFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ScannerFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: SizedBox(
        width: 95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withValues(alpha:.30),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D1B2A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
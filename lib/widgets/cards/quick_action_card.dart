import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
  splashColor: const Color(0xFFD4AF37).withValues(alpha: 0.15),
  highlightColor: Colors.transparent,
  borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
  horizontal: 16,
  vertical: 14,
),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
  Container(
    width: 50,
    height: 50,
    decoration: const BoxDecoration(
      color: Color(0xFFFFF8E1),
      shape: BoxShape.circle,
    ),
    child: Icon(
      icon,
      size: 24,
      color: Color(0xFFD4AF37),
    ),
  ),

  const SizedBox(height: 10),

  Text(
    title,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1F2937),
    ),
  ),

  const SizedBox(height: 6),

  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      subtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 12,
        color:  Color(0xFF6B7280),
        height: 1.4,
      ),
    ),
  ),

  const SizedBox(height: 10),

  const Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(right: 14),
      child: Icon(
        Icons.arrow_outward_rounded,
        size: 18,
        color: Color(0xFFD4AF37),
      ),
    ),
  ),
],
          ),
        ),
      ),
    );
  }
}
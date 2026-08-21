import 'package:flutter/material.dart';

class LawyerAboutCard extends StatelessWidget {
  const LawyerAboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProfileSection(
      title: 'About Me',
      child: Text(
        'I am a professional lawyer practicing in criminal law, '
        'bail matters, and constitutional law. I have 8+ years '
        'of experience handling various legal matters with '
        'dedication and commitment.',
        style: TextStyle(
          color: Color(0xFF475569),
          fontSize: 15,
          height: 1.6,
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _ProfileSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F1B35),
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE8EDF3),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
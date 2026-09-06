
import 'package:flutter/material.dart';

class VerificationIntroCard extends StatelessWidget {
  const VerificationIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha:0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: Color(0xFFD4AF37),
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text(
                  'Verify Your Credentials',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            'LawLink360 verifies your professional credentials '
            'before your lawyer profile is presented to clients.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          const _VerificationPoint(
            icon: Icons.badge_outlined,
            text: 'Upload your Bar Council / Bar Card.',
          ),

          const SizedBox(height: 10),

          const _VerificationPoint(
            icon: Icons.credit_card_outlined,
            text: 'Upload your Government ID Card.',
          ),

          const SizedBox(height: 10),

          const _VerificationPoint(
            icon: Icons.lock_outline,
            text: 'Your documents remain private and are not shown publicly.',
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFFD4AF37),
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'After your credentials are successfully verified, '
                    'clients will be informed that LawLink360 has verified '
                    'your professional credentials.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const _VerificationPoint({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFFD4AF37),
          size: 19,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

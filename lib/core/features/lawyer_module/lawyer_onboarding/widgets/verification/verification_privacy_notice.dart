
import 'package:flutter/material.dart';

class VerificationPrivacyNotice extends StatelessWidget {
  const VerificationPrivacyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD6E8FF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: Color(0xFF0D1B2A),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'Your Credentials Are Private',
                  style: TextStyle(
                    color: Color(0xFF0D1B2A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            'The Bar Card and Government ID Card you provide are '
            'collected only for LawLink360 credential verification.',
            style: TextStyle(
              color: Color(0xFF334155),
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 12),

          const _PrivacyPoint(
            icon: Icons.visibility_off_outlined,
            text:
                'Your document images will not be displayed to clients or other lawyers.',
          ),

          const SizedBox(height: 9),

          const _PrivacyPoint(
            icon: Icons.security_outlined,
            text:
                'Your credentials will be kept private and handled through the LawLink360 verification process.',
          ),

          const SizedBox(height: 9),

          const _PrivacyPoint(
            icon: Icons.verified_user_outlined,
            text:
                'The documents are used to confirm your professional and identity credentials.',
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Color(0xFFD4AF37),
                  size: 19,
                ),

                SizedBox(width: 8),

                Expanded(
                  child: Text(
                    'After successful verification, your public profile '
                    'may display a LawLink360 Verified indication. '
                    'The Verified Badge is subject to LawLink360 verification '
                    'requirements and the applicable verification fee.',
                    style: TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 12,
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

class _PrivacyPoint extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PrivacyPoint({
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
          size: 18,
          color: const Color(0xFF0D1B2A),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF475569),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

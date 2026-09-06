
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class ProfessionalInfoAbout extends ConsumerWidget {
  const ProfessionalInfoAbout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final about = ref
        .read(lawyerOnboardingProvider.notifier)
        .professionalInfo
        .about;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About You',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Tell clients about your legal experience, expertise, and professional background.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 18),

          TextFormField(
            initialValue: about,
            maxLines: 6,
            maxLength: 500,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText:
                  'Write a short professional introduction...',
              alignLabelWithHint: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  right: 8,
                  top: 14,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Color(0xFFD4AF37),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F7FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFD4AF37),
                  width: 1.5,
                ),
              ),
            ),
            onChanged: (value) {
              ref
                  .read(lawyerOnboardingProvider.notifier)
                  .updateAbout(value.trim());
            },
          ),
        ],
      ),
    );
  }
}

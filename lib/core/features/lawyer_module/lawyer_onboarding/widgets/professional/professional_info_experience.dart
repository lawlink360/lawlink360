
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class ProfessionalInfoExperience extends ConsumerWidget {
  const ProfessionalInfoExperience({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedYears = ref
        .read(lawyerOnboardingProvider.notifier)
        .professionalInfo
        .yearsOfExperience;

    final years = selectedYears == 0 ? null : selectedYears;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Legal Experience',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'How many years have you been practicing law?',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 18),

          DropdownButtonFormField<int>(
            value: years,
            decoration: InputDecoration(
              labelText: 'Years of Experience',
              prefixIcon: const Icon(
                Icons.work_outline,
                color: Color(0xFFD4AF37),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F7FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            items: List.generate(
              51,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: Text(
                  index == 0
                      ? 'Less than 1 year'
                      : '$index ${index == 1 ? 'year' : 'years'}',
                ),
              ),
            ),
            onChanged: (value) {
              if (value == null) return;

              ref
                  .read(lawyerOnboardingProvider.notifier)
                  .updateYearsOfExperience(value);
            },
          ),
        ],
      ),
    );
  }
}

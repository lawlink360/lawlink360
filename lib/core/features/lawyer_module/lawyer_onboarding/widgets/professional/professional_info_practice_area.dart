import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class ProfessionalInfoPracticeArea extends ConsumerWidget {
  const ProfessionalInfoPracticeArea({super.key});

  static const List<String> practiceAreas = [
    'Civil Law',
    'Criminal Law',
    'Family Law',
    'Constitutional Law',
    'Corporate Law',
    'Commercial Law',
    'Property Law',
    'Banking Law',
    'Labour Law',
    'Tax Law',
    'Intellectual Property',
    'Cyber Law',
    'Immigration Law',
    'Human Rights Law',
    'Administrative Law',
    'Service Law',
    'Environmental Law',
    'Election Law',
    'Customs Law',
    'Consumer Law',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(lawyerOnboardingProvider);

    final selectedAreas =
        ref.read(lawyerOnboardingProvider.notifier)
            .professionalInfo.practiceAreas;

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
            'Practice Areas',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Select the areas of law you practice.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: practiceAreas.map((area) {
              final isSelected = selectedAreas.contains(area);

              return FilterChip(
                label: Text(area),
                selected: isSelected,
                onSelected: (selected) {
                  final notifier =
                      ref.read(lawyerOnboardingProvider.notifier);

                  final updatedAreas = List<String>.from(selectedAreas);

                  if (selected) {
                    updatedAreas.add(area);
                  } else {
                    updatedAreas.remove(area);
                  }

                  notifier.updatePracticeAreas(updatedAreas);
                },
                selectedColor: const Color(0xFFD4AF37).withValues(alpha:0.20),
                checkmarkColor: const Color(0xFF0D1B2A),
                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF0D1B2A)
                      : Colors.black87,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                backgroundColor: const Color(0xFFF5F7FB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? const Color(0xFFD4AF37)
                        : Colors.transparent,
                  ),
                ),
              );
            }).toList(),
          ),

          if (selectedAreas.isEmpty) ...[
            const SizedBox(height: 14),
            const Text(
              'Please select at least one practice area.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
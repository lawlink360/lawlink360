import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class ProfessionalInfoCourtSelector extends ConsumerWidget {
  const ProfessionalInfoCourtSelector({super.key});

  static const List<String> courts = [
    'District Courts',
    'Sessions Courts',
    'High Court',
    'Supreme Court',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // IMPORTANT:
    // watch the provider so the widget rebuilds when onboarding state changes.
    ref.watch(lawyerOnboardingProvider);

    final selectedCourts = ref
        .read(lawyerOnboardingProvider.notifier)
        .professionalInfo
        .courts;

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
            'Courts You Practice In',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B2A),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Select the courts where you regularly practice.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: courts.map((court) {
              final isSelected = selectedCourts.contains(court);

              return FilterChip(
                label: Text(court),
                selected: isSelected,

                onSelected: (selected) {
                  final notifier =
                      ref.read(lawyerOnboardingProvider.notifier);

                  final updatedCourts =
                      List<String>.from(selectedCourts);

                  if (selected) {
                    if (!updatedCourts.contains(court)) {
                      updatedCourts.add(court);
                    }
                  } else {
                    updatedCourts.remove(court);
                  }

                  notifier.updateCourts(updatedCourts);
                },

                selectedColor:
                    const Color(0xFFD4AF37).withOpacity(0.20),

                checkmarkColor:
                    const Color(0xFF0D1B2A),

                labelStyle: TextStyle(
                  color: isSelected
                      ? const Color(0xFF0D1B2A)
                      : Colors.black87,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),

                backgroundColor:
                    const Color(0xFFF5F7FB),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? const Color(0xFFD4AF37)
                        : Colors.transparent,
                    width: 1.2,
                  ),
                ),
              );
            }).toList(),
          ),

          if (selectedCourts.isEmpty) ...[
            const SizedBox(height: 14),

            const Text(
              'Please select at least one court.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ] else ...[
            const SizedBox(height: 14),

            Text(
              '${selectedCourts.length} court${selectedCourts.length == 1 ? '' : 's'} selected',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF0D1B2A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
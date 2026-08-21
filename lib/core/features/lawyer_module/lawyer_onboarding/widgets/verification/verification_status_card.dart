
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/models/lawyer_verification_model.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class VerificationStatusCard extends ConsumerWidget {
  const VerificationStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verification =
        ref.watch(lawyerOnboardingProvider.notifier).verificationInfo;

    final status = verification.status;

    final statusData = _getStatusData(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: statusData.color.withOpacity(0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: statusData.color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              statusData.icon,
              color: statusData.color,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verification Status',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  statusData.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: statusData.color,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  statusData.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),

                if (verification.verificationNote != null &&
                    verification.verificationNote!.trim().isNotEmpty) ...[
                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      verification.verificationNote!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0D1B2A),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  _StatusData _getStatusData(
    LawyerVerificationStatus status,
  ) {
    switch (status) {
      case LawyerVerificationStatus.notSubmitted:
        return const _StatusData(
          title: 'Not Submitted',
          description:
              'Your verification documents have not been submitted yet.',
          color: Colors.grey,
          icon: Icons.assignment_outlined,
        );

      case LawyerVerificationStatus.underReview:
        return const _StatusData(
          title: 'Under Review',
          description:
              'Your documents have been submitted and are being reviewed by LawLink360.',
          color: Colors.orange,
          icon: Icons.hourglass_top_rounded,
        );

      case LawyerVerificationStatus.verified:
        return const _StatusData(
          title: 'Credentials Verified',
          description:
              'LawLink360 has successfully verified your professional credentials.',
          color: Colors.green,
          icon: Icons.verified_rounded,
        );

      case LawyerVerificationStatus.resubmissionRequired:
        return const _StatusData(
          title: 'Resubmission Required',
          description:
              'Some verification information needs to be submitted again.',
          color: Colors.orange,
          icon: Icons.refresh_rounded,
        );

      case LawyerVerificationStatus.rejected:
        return const _StatusData(
          title: 'Verification Rejected',
          description:
              'Your verification request was not approved. Please review the provided note.',
          color: Colors.red,
          icon: Icons.cancel_outlined,
        );
    }
  }
}

class _StatusData {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const _StatusData({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });
}

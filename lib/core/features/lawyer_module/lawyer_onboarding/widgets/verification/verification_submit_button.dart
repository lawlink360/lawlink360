
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/screens/verification_processing_screen.dart';

class VerificationSubmitButton extends ConsumerWidget {
  final VoidCallback? onSubmitted;

  const VerificationSubmitButton({
    super.key,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {
          _submitVerification(
            context: context,
            ref: ref,
          );
        },
        icon: const Icon(
          Icons.verified_user_outlined,
        ),
        label: const Text(
          'Submit for Verification',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4AF37),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  void _submitVerification({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final notifier =
        ref.read(lawyerOnboardingProvider.notifier);

    final verification = notifier.verificationInfo;

    final missingDocuments = <String>[];

    // ------------------------------------------------------------
    // CHECK BAR CARD
    // ------------------------------------------------------------

    if (verification.barCardFrontPath == null ||
        verification.barCardFrontPath!.isEmpty) {
      missingDocuments.add('Bar Card Front');
    }

    if (verification.barCardBackPath == null ||
        verification.barCardBackPath!.isEmpty) {
      missingDocuments.add('Bar Card Back');
    }

    // ------------------------------------------------------------
    // CHECK ID CARD
    // ------------------------------------------------------------

    if (verification.idCardFrontPath == null ||
        verification.idCardFrontPath!.isEmpty) {
      missingDocuments.add('ID Card Front');
    }

    if (verification.idCardBackPath == null ||
        verification.idCardBackPath!.isEmpty) {
      missingDocuments.add('ID Card Back');
    }

    // ------------------------------------------------------------
    // SHOW MISSING DOCUMENTS
    // ------------------------------------------------------------

    if (missingDocuments.isNotEmpty) {
      _showMessage(
        context,
        'Please upload: ${missingDocuments.join(', ')}',
      );
      return;
    }

    // ------------------------------------------------------------
    // MARK VERIFICATION AS SUBMITTED
    // ------------------------------------------------------------

    notifier.submitVerification();

    // ------------------------------------------------------------
    // OPEN VERIFICATION PROCESSING SCREEN
    // ------------------------------------------------------------

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const VerificationProcessingScreen(),
      ),
    );

    // ------------------------------------------------------------
    // OPTIONAL CALLBACK
    // ------------------------------------------------------------

    onSubmitted?.call();
  }

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

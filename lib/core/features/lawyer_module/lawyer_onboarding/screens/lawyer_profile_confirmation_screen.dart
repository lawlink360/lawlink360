import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/lawyer_onboarding_provider.dart';
import '../widgets/onboarding/onboarding_progress.dart';
import '../../home/screens/lawyer_home_screen.dart';


class LawyerProfileConfirmationScreen extends ConsumerWidget {
  const LawyerProfileConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basicInfo = ref.watch(lawyerOnboardingProvider);
    final notifier = ref.read(lawyerOnboardingProvider.notifier);
    final professionalInfo = notifier.professionalInfo;
    final verificationInfo = notifier.verificationInfo;

    final hasProfileImage =
        basicInfo.profileImagePath != null &&
        basicInfo.profileImagePath!.isNotEmpty;

    final isVerificationSubmitted =
        verificationInfo.status.toString().contains('underReview');

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Confirm Your Profile',
          style: TextStyle(
            color: Color(0xFF0D1B2A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Review Your Lawyer Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Review the information below before completing your lawyer onboarding.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 18),

              const OnboardingProgress(
                currentStep: 5,
                totalSteps: 5,
              ),

              const SizedBox(height: 24),

              // --------------------------------------------------
              // PROFILE PREVIEW
              // --------------------------------------------------

              _ProfilePreviewCard(
                imagePath: hasProfileImage
                    ? basicInfo.profileImagePath
                    : null,
                name: basicInfo.fullName,
                city: basicInfo.city,
                practiceAreas: professionalInfo.practiceAreas,
                yearsOfExperience:
                    professionalInfo.yearsOfExperience,
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // BASIC INFORMATION
              // --------------------------------------------------

              _SectionCard(
                title: 'Basic Information',
                icon: Icons.person_outline,
                children: [
                  _InfoRow(
                    label: 'Full Name',
                    value: _displayValue(basicInfo.fullName),
                  ),
                  _InfoRow(
                    label: 'Phone',
                    value: _displayValue(basicInfo.phoneNumber),
                  ),
                  _InfoRow(
                    label: 'Email',
                    value: _displayValue(basicInfo.email),
                  ),
                  _InfoRow(
                    label: 'Gender',
                    value: _displayValue(basicInfo.gender),
                  ),
                  _InfoRow(
                    label: 'City',
                    value: _displayValue(basicInfo.city),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // PROFESSIONAL INFORMATION
              // --------------------------------------------------

              _SectionCard(
                title: 'Professional Information',
                icon: Icons.work_outline,
                children: [
                  _InfoRow(
                    label: 'Practice Areas',
                    value: professionalInfo.practiceAreas.isEmpty
                        ? 'Not provided'
                        : professionalInfo.practiceAreas.join(', '),
                  ),
                  _InfoRow(
                    label: 'Experience',
                    value:
                        '${professionalInfo.yearsOfExperience} years',
                  ),
                  _InfoRow(
                    label: 'License Number',
                    value:
                        _displayValue(professionalInfo.licenseNumber),
                  ),
                  _InfoRow(
                    label: 'Courts',
                    value: professionalInfo.courts.isEmpty
                        ? 'Not provided'
                        : professionalInfo.courts.join(', '),
                  ),
                  _InfoRow(
                    label: 'About',
                    value: _displayValue(professionalInfo.about),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // VERIFICATION SUMMARY
              // --------------------------------------------------

              _VerificationSummaryCard(
                submitted: isVerificationSubmitted,
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // PRIVACY NOTICE
              // --------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFD6E8FF),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: Color(0xFF0D1B2A),
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your Bar Card and Government ID Card are private '
                        'verification documents. They will not be displayed '
                        'to clients or other lawyers.',
                        style: TextStyle(
                          color: Color(0xFF334155),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --------------------------------------------------
              // VERIFIED BADGE INFORMATION
              // --------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha:0.35),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xFFD4AF37),
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'LawLink360 Verified Badge',
                        style: TextStyle(
                          color: Color(0xFF0D1B2A),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'The Verified Badge will only be displayed after LawLink360 '
                'successfully verifies your credentials and the applicable '
                'verification requirements and fee are completed.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 30),

              // --------------------------------------------------
              // COMPLETE ONBOARDING
              // --------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    _completeOnboarding(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Complete Lawyer Onboarding',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.check_circle_outline,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              const Center(
                child: Text(
                  'You can update your profile information later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _displayValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Not provided';
    }

    return value.trim();
  }

  void _completeOnboarding(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LawyerHomeScreen(),
      ),
      (route) => false,
    );
  }
}

// ============================================================
// PROFILE PREVIEW
// ============================================================

class _ProfilePreviewCard extends StatelessWidget {
  final String? imagePath;
  final String? name;
  final String? city;
  final List<String> practiceAreas;
  final int yearsOfExperience;

  const _ProfilePreviewCard({
    required this.imagePath,
    required this.name,
    required this.city,
    required this.practiceAreas,
    required this.yearsOfExperience,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imagePath != null && imagePath!.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFD4AF37),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: hasImage
                  ? Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 48,
                      color: Colors.white70,
                    ),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            _displayName(name),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            _displayCity(city),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 14),

          if (practiceAreas.isNotEmpty)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 7,
              runSpacing: 7,
              children: practiceAreas
                  .map(
                    (area) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37)
                            .withValues(alpha:0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        area,
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

          const SizedBox(height: 14),

          Text(
            '$yearsOfExperience years of legal experience',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 14),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_top_rounded,
                color: Color(0xFFD4AF37),
                size: 18,
              ),
              SizedBox(width: 6),
              Text(
                'Verification Pending',
                style: TextStyle(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _displayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Lawyer Name';
    }

    return value.trim();
  }

  static String _displayCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City not provided';
    }

    return value.trim();
  }
}

// ============================================================
// SECTION CARD
// ============================================================

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFD4AF37),
                size: 22,
              ),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF0D1B2A),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ...children,
        ],
      ),
    );
  }
}

// ============================================================
// INFORMATION ROW
// ============================================================

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11.5,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0D1B2A),
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VERIFICATION SUMMARY
// ============================================================

class _VerificationSummaryCard extends StatelessWidget {
  final bool submitted;

  const _VerificationSummaryCard({
    required this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: submitted
              ? Colors.orange.withValues(alpha:0.3)
              : Colors.grey.withValues(alpha:0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            submitted
                ? Icons.hourglass_top_rounded
                : Icons.assignment_outlined,
            color: submitted
                ? Colors.orange
                : Colors.grey,
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Credential Verification',
                  style: TextStyle(
                    color: Color(0xFF0D1B2A),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  submitted
                      ? 'Your credentials have been submitted and are currently under review.'
                      : 'Your credentials are ready for submission.',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your uploaded documents remain private.',
                  style: TextStyle(
                    color: Color(0xFF0D1B2A),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
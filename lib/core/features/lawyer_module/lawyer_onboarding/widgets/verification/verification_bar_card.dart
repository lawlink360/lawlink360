
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class VerificationBarCard extends ConsumerWidget {
  const VerificationBarCard({super.key});

  Future<void> _pickImage({
    required BuildContext context,
    required WidgetRef ref,
    required bool isFront,
  }) async {
    final picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Image',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B2A),
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF5F7FB),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),
                  title: const Text('Take Photo'),
                  onTap: () {
                    Navigator.pop(
                      context,
                      ImageSource.camera,
                    );
                  },
                ),

                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF5F7FB),
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),
                  title: const Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.pop(
                      context,
                      ImageSource.gallery,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null) return;

    final image = await picker.pickImage(
      source: source,
      imageQuality: 85,
    );

    if (image == null) return;

    final notifier =
        ref.read(lawyerOnboardingProvider.notifier);

    if (isFront) {
      notifier.updateBarCardFront(image.path);
    } else {
      notifier.updateBarCardBack(image.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verification =
        ref.read(lawyerOnboardingProvider.notifier).verificationInfo;

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
          const Row(
            children: [
              Icon(
                Icons.badge_outlined,
                color: Color(0xFFD4AF37),
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Bar Council / Bar Card',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1B2A),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Text(
            'Upload clear images of both sides of your Bar Card.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _DocumentImageBox(
                  title: 'Front Side',
                  imagePath: verification.barCardFrontPath,
                  onTap: () => _pickImage(
                    context: context,
                    ref: ref,
                    isFront: true,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _DocumentImageBox(
                  title: 'Back Side',
                  imagePath: verification.barCardBackPath,
                  onTap: () => _pickImage(
                    context: context,
                    ref: ref,
                    isFront: false,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_outline,
                size: 17,
                color: Colors.grey,
              ),
              SizedBox(width: 7),
              Expanded(
                child: Text(
                  'This document is private and will only be used '
                  'for LawLink360 credential verification.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocumentImageBox extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback onTap;

  const _DocumentImageBox({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imagePath != null && imagePath!.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasImage
                ? const Color(0xFFD4AF37)
                : Colors.grey.shade300,
          ),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_a_photo_outlined,
                    size: 32,
                    color: Color(0xFFD4AF37),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0D1B2A),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Tap to upload',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

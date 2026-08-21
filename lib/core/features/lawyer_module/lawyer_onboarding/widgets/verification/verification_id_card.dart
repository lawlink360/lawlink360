
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lawlink360/core/features/lawyer_module/lawyer_onboarding/providers/lawyer_onboarding_provider.dart';

class VerificationIdCard extends ConsumerStatefulWidget {
  const VerificationIdCard({super.key});

  @override
  ConsumerState<VerificationIdCard> createState() =>
      _VerificationIdCardState();
}

class _VerificationIdCardState
    extends ConsumerState<VerificationIdCard> {
  bool _isPickingFront = false;
  bool _isPickingBack = false;

  Future<void> _pickImage({
    required bool isFront,
  }) async {
    final picker = ImagePicker();

    if (isFront) {
      setState(() {
        _isPickingFront = true;
      });
    } else {
      setState(() {
        _isPickingBack = true;
      });
    }

    try {
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

                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );

      if (source == null) {
        return;
      }

      final image = await picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      if (!mounted) return;

      final notifier =
          ref.read(lawyerOnboardingProvider.notifier);

      if (isFront) {
        notifier.updateIdCardFront(image.path);
      } else {
        notifier.updateIdCardBack(image.path);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to select the image. Please try again.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          if (isFront) {
            _isPickingFront = false;
          } else {
            _isPickingBack = false;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // IMPORTANT:
    // watch the provider so this widget rebuilds immediately
    // when the ID card paths are updated.
    final onboarding = ref.watch(lawyerOnboardingProvider);

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
            color: Colors.black.withOpacity(0.04),
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
                Icons.credit_card_outlined,
                color: Color(0xFFD4AF37),
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Government ID Card',
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
            'Upload clear images of both sides of your Government ID Card.',
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
                  imagePath: verification.idCardFrontPath,
                  isLoading: _isPickingFront,
                  onTap: () => _pickImage(
                    isFront: true,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _DocumentImageBox(
                  title: 'Back Side',
                  imagePath: verification.idCardBackPath,
                  isLoading: _isPickingBack,
                  onTap: () => _pickImage(
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
                  'Your ID Card is private and will only be used '
                  'for LawLink360 identity verification.',
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
  final bool isLoading;
  final VoidCallback onTap;

  const _DocumentImageBox({
    required this.title,
    required this.imagePath,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        imagePath != null && imagePath!.isNotEmpty;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasImage
                ? const Color(0xFFD4AF37)
                : Colors.grey.shade300,
            width: hasImage ? 1.5 : 1,
          ),
        ),
        child: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Processing...',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : hasImage
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      // Selected indicator
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4AF37),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),

                      // Replace label
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Tap to replace',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
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

import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import 'document_editor_screen.dart';

class DocumentCropScreen extends StatefulWidget {
  final String imagePath;

  const DocumentCropScreen({
    super.key,
    required this.imagePath,
  });

  @override
  State<DocumentCropScreen> createState() => _DocumentCropScreenState();
}

class _DocumentCropScreenState extends State<DocumentCropScreen> {
  final CropController _cropController = CropController();

  late final Uint8List _imageData;

  bool _isCropping = false;

  @override
  void initState() {
    super.initState();

    _imageData = File(widget.imagePath).readAsBytesSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Crop Document',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Crop(
        controller: _cropController,
        image: _imageData,
        baseColor: Colors.black,
        maskColor: Colors.black.withValues(alpha: 0.55),
        cornerDotBuilder: (_, _) {
          return Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          );
        },
        onCropped: (result) async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);

          switch (result) {
            case CropSuccess():
              final file = File(widget.imagePath);

              await file.writeAsBytes(result.croppedImage);

              if (!mounted) return;

              navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (_) => DocumentEditorScreen(
                    imagePath: file.path,
                  ),
                ),
              );

              break;

            case CropFailure():
              if (!mounted) return;

              setState(() {
                _isCropping = false;
              });

              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    result.cause.toString(),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ),
              );

              break;
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: SizedBox(
            height: AppSpacing.buttonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.primary,
                disabledBackgroundColor:
                    AppColors.accent.withValues(alpha: 0.45),
                disabledForegroundColor:
                    AppColors.primary.withValues(alpha: 0.65),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              onPressed: _isCropping
                  ? null
                  : () {
                      setState(() {
                        _isCropping = true;
                      });

                      _cropController.crop();
                    },
              child: _isCropping
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.primary,
                      ),
                    )
                  : Text(
                      'Apply Crop',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
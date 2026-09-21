import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../models/scanner_page.dart';

/// Preview widget for the editor screen.
///
/// Two display modes:
///  - normal: shows the current page image.
///  - crop: shows the installed [Crop] widget for manual crop.
///
/// The parent owns the crop-mode flag and receives the cropped
/// bytes through [onCropComplete]. The parent is responsible for
/// writing the bytes to a file and updating the page.
class ScannerEditorPreview extends StatefulWidget {
  const ScannerEditorPreview({
    super.key,
    required this.page,
    required this.isCropMode,
    required this.onCropComplete,
    required this.onCropCancelled,
  });

  final ScannerPage page;
  final bool isCropMode;
  final ValueChanged<Uint8List> onCropComplete;
  final VoidCallback onCropCancelled;

  @override
  State<ScannerEditorPreview> createState() =>
      _ScannerEditorPreviewState();
}

class _ScannerEditorPreviewState extends State<ScannerEditorPreview> {
  Uint8List? _imageBytes;
  final CropController _cropController = CropController();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(covariant ScannerEditorPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.page.imagePath != widget.page.imagePath) {
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    final path = widget.page.imagePath;
    try {
      final bytes = await File(path).readAsBytes();
      if (!mounted) return;
      setState(() {
        _imageBytes = bytes;
      });
    } catch (e, st) {
      debugPrint('SCANNER EDITOR IMAGE LOAD FAILED');
      debugPrint('Path: $path');
      debugPrint('Error: $e');
      debugPrint('$st');

      if (!mounted) return;
      setState(() {
        _imageBytes = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bytes = _imageBytes;

    if (bytes == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.primary,
          ),
        ),
      );
    }

    if (widget.isCropMode) {
      return Crop(
        image: bytes,
        controller: _cropController,
        onCropped: _handleCropped,
        interactive: true,
        baseColor: AppColors.primary,
        maskColor: AppColors.overlayDark,
        progressIndicator: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.accent,
            ),
          ),
        ),
      );
    }

    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 4.0,
      child: Center(
        child: Image.memory(
          bytes,
          fit: BoxFit.contain,
          gaplessPlayback: true,
        ),
      ),
    );
  }

  void _handleCropped(CropResult result) {
    switch (result) {
      case CropSuccess(:final croppedImage):
        widget.onCropComplete(croppedImage);
      case CropFailure(:final cause):
        widget.onCropCancelled();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Crop failed: $cause')),
        );
    }
  }
}
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/scanner/models/scanner_mode.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../services/camera_service.dart';
import '../widgets/smart_camera_bottom_bar.dart';
import '../widgets/smart_camera_overlay.dart';
import '../widgets/smart_camera_top_modes.dart';
import 'document_preview_screen.dart';

class SmartCameraScreen extends StatefulWidget {
  final ScannerMode initialMode;

  const SmartCameraScreen({
    super.key,
    required this.initialMode,
  });

  @override
  State<SmartCameraScreen> createState() => _SmartCameraScreenState();
}

class _SmartCameraScreenState extends State<SmartCameraScreen> {
  CameraController? _controller;
  bool _cameraReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _capturePhoto() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    try {
      final image = await _controller!.takePicture();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DocumentPreviewScreen(
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Capture failed: $e',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ),
      );
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = CameraService.cameras;

    if (cameras == null || cameras.isEmpty) return;

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      _cameraReady = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String getTitle() {
    switch (widget.initialMode) {
      case ScannerMode.document:
        return 'Document Scanner';
      case ScannerMode.idCard:
        return 'ID Card Scanner';
      case ScannerMode.book:
        return 'Book Scanner';
      case ScannerMode.whiteboard:
        return 'Whiteboard Scanner';
      case ScannerMode.ocr:
        return 'OCR Scanner';
      case ScannerMode.translate:
        return 'Translate Scanner';
      case ScannerMode.qrCode:
        return 'QR Code Scanner';
      case ScannerMode.idPhotoMaker:
        return 'ID Photo Maker';
      case ScannerMode.timeStamp:
        return 'Time Stamp Camera';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          getTitle(),
          style: AppTextStyles.title.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(
                  AppSpacing.sm,
                  AppSpacing.xs,
                  AppSpacing.sm,
                  0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.darkBorder,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: _cameraReady && _controller != null
                      ? SmartCameraOverlay(
                          controller: _controller!,
                        )
                      : const CircularProgressIndicator(
                          color: AppColors.accent,
                          strokeWidth: 2.5,
                        ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const SmartCameraTopModes(),
            const SizedBox(height: AppSpacing.xs),
            SmartCameraBottomBar(
              onCapture: _capturePhoto,
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../models/scanner_mode.dart';
import '../providers/scanner_camera_provider.dart';
import '../providers/scanner_ocr_provider.dart';
import '../providers/scanner_pages_provider.dart';
import '../providers/scanner_processing_provider.dart';
import '../providers/scanner_session_provider.dart';
import '../providers/scanner_settings_provider.dart';
import '../widgets/camera/scanner_camera_bottom_bar.dart';
import '../widgets/camera/scanner_camera_overlay.dart';
import '../widgets/camera/scanner_camera_preview.dart';
import '../widgets/camera/scanner_camera_top_bar.dart';
import '../widgets/shared/scanner_loading_overlay.dart';
import 'scanner_multi_page_screen.dart';
import 'scanner_preview_screen.dart';

/// Camera screen for Scanner 360.
///
/// When [autoOpenGallery] is true, the gallery picker is opened
/// automatically after the first frame.
class ScannerCameraScreen extends ConsumerStatefulWidget {
  const ScannerCameraScreen({
    super.key,
    this.autoOpenGallery = false,
  });

  final bool autoOpenGallery;

  @override
  ConsumerState<ScannerCameraScreen> createState() =>
      _ScannerCameraScreenState();
}

class _ScannerCameraScreenState
    extends ConsumerState<ScannerCameraScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(scannerCameraProvider.notifier).initialize();
    });

    if (widget.autoOpenGallery) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _handleGallery();
      });
    }
  }

  @override
  void dispose() {
    ref.read(scannerCameraProvider.notifier).disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCapturing = ref.watch(scannerCameraProvider).isCapturing;
    final session = ref.watch(scannerSessionProvider);
    final mode = session?.mode ?? ScannerMode.document;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            const ScannerCameraPreview(),
            ScannerCameraOverlay(mode: mode),
            Positioned(
              top: AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: ScannerCameraTopBar(
                onClose: _handleClose,
              ),
            ),
            Positioned(
              bottom: AppSpacing.lg,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              child: ScannerCameraBottomBar(
                onCapture: _handleCapture,
                onOpenGallery: _handleGallery,
                onOpenPages: _handleOpenPages,
              ),
            ),
            if (isCapturing)
              const ScannerLoadingOverlay(
                label: 'Processingâ€¦',
              ),
          ],
        ),
      ),
    );
  }

  void _handleClose() {
    Navigator.of(context).pop();
  }

  Future<void> _handleOpenPages() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerMultiPageScreen(),
      ),
    );
    if (result == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleCapture() async {
    final path =
        await ref.read(scannerCameraProvider.notifier).capture();
    if (path == null) {
      final error = ref.read(scannerCameraProvider).error;
      _showSnackBar(error ?? 'Failed to capture image.');
      return;
    }
    await _processAndAddPage(path);
  }

  Future<void> _handleGallery() async {
    final path = await ref
        .read(scannerCameraProvider.notifier)
        .pickFromGallery();
    if (path == null) return;
    await _processAndAddPage(path);
  }

  Future<void> _processAndAddPage(String capturedFilePath) async {
    final session = ref.read(scannerSessionProvider);
    if (session == null) {
      _showSnackBar('No active scanning session.');
      return;
    }

    final pageId = DateTime.now().microsecondsSinceEpoch.toString();
    final settings = ref.read(scannerSettingsProvider);

    final page = await ref
        .read(scannerProcessingProvider.notifier)
        .processCapturedPage(
          sessionId: session.id,
          capturedFilePath: capturedFilePath,
          pageId: pageId,
          settings: settings,
        );

    if (page == null) {
      _showSnackBar('Failed to process the captured image.');
      return;
    }

    ref.read(scannerPagesProvider.notifier).addPage(page);

    if (session.mode == ScannerMode.ocr) {
      await ref.read(scannerOcrProvider.notifier).runOcrOnPage(
            page: page,
            language: settings.ocrLanguage,
          );
    }

    final mode = session.mode;
    if (mode != ScannerMode.batch) {
      if (!mounted) return;
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (_) => const ScannerPreviewScreen(),
        ),
      );
      if (result == true && mounted) {
        Navigator.of(context).pop(true);
      }
    } else {
      _showSnackBar('Page added');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
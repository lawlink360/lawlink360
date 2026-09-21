import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../models/scan_filter.dart';
import '../models/scanner_page.dart';
import '../providers/scanner_pages_provider.dart';
import '../services/scanner_image_processing_service.dart';
import '../services/scanner_storage_service.dart';
import '../widgets/editor/scanner_editor_adjustment_sheet.dart';
import '../widgets/editor/scanner_editor_filter_sheet.dart';
import '../widgets/editor/scanner_editor_preview.dart';
import '../widgets/editor/scanner_editor_rotate_sheet.dart';
import '../widgets/editor/scanner_editor_toolbar.dart';
import '../widgets/shared/scanner_error_view.dart';

/// Editor screen for Scanner 360.
///
/// Edits the current page ([ScannerPagesState.activePageIndex]).
/// Does not navigate between pages. Multi-page navigation is a
/// later concern.
class ScannerEditorScreen extends ConsumerStatefulWidget {
  const ScannerEditorScreen({super.key});

  @override
  ConsumerState<ScannerEditorScreen> createState() =>
      _ScannerEditorScreenState();
}

class _ScannerEditorScreenState
    extends ConsumerState<ScannerEditorScreen> {
  final ScannerImageProcessingService _imageProcessing =
      const ScannerImageProcessingService();
  final ScannerStorageService _storage = const ScannerStorageService();

  bool _isCropMode = false;
  bool _isBusy = false;

  // Pending edits, applied only on Save.
  ScanFilter? _pendingFilter;
  double? _pendingBrightness;
  double? _pendingContrast;
  double? _pendingSaturation;
  double? _pendingGamma;

  // In-memory undo / redo for page-level changes (crop, rotation).
  final List<ScannerPage> _undoStack = [];
  final List<ScannerPage> _redoStack = [];

  int? _lastIndex;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerPagesProvider);

    if (state.pages.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: AppBar(
          backgroundColor: AppColors.lightSurface,
          foregroundColor: AppColors.lightTextPrimary,
          elevation: 0,
          title: const Text('Editor'),
        ),
        body: ScannerErrorView(
          title: 'No page to edit',
          message: 'Capture a page before opening the editor.',
          onRetry: () => Navigator.of(context).pop(),
          retryLabel: 'Back',
        ),
      );
    }

    final index = state.activePageIndex.clamp(
      0,
      state.pages.length - 1,
    );

    if (_lastIndex != index) {
      _lastIndex = index;
      _undoStack.clear();
      _redoStack.clear();
      _pendingFilter = null;
      _pendingBrightness = null;
      _pendingContrast = null;
      _pendingSaturation = null;
      _pendingGamma = null;
    }

    final page = state.pages[index];

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Edit Page'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ScannerEditorPreview(
              key: ValueKey(page.imagePath),
              page: page,
              isCropMode: _isCropMode,
              onCropComplete: (bytes) =>
                  _handleCropComplete(bytes, index, page),
              onCropCancelled: () =>
                  setState(() => _isCropMode = false),
            ),
          ),
          if (_isBusy)
            const Positioned.fill(
              child: ColoredBox(
                color: AppColors.overlayDark,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accent,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: ScannerEditorToolbar(
        onCrop: _handleCropTap,
        onRotateLeft: () =>
            _handleRotateBy(-90.0, index, page),
        onRotateRight: () =>
            _handleRotateBy(90.0, index, page),
        onOpenAngleSheet: () =>
            _handleOpenRotateSheet(index, page),
        onOpenFilterSheet: () => _handleOpenFilterSheet(
          index,
          page,
        ),
        onOpenAdjustmentSheet: _handleOpenAdjustmentSheet,
        onUndo: () => _handleUndo(index),
        onRedo: () => _handleRedo(index),
        onRetake: () => _handleRetake(index),
        onSave: () => _handleSave(index),
        canUndo: _undoStack.isNotEmpty,
        canRedo: _redoStack.isNotEmpty,
      ),
    );
  }

  // ------------------------------------------------------------
  // Crop
  // ------------------------------------------------------------

  void _handleCropTap() {
    setState(() => _isCropMode = true);
  }

  Future<void> _handleCropComplete(
    Uint8List bytes,
    int index,
    ScannerPage currentPage,
  ) async {
    setState(() {
      _isCropMode = false;
      _isBusy = true;
    });

    try {
      final newPath = await _buildEditPath(currentPage.id);
      await File(newPath).writeAsBytes(bytes, flush: true);
      final updated = currentPage.copyWith(imagePath: newPath);

      _pushUndo(currentPage);
      ref.read(scannerPagesProvider.notifier).replacePage(index, updated);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Crop failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  // ------------------------------------------------------------
  // Rotate
  // ------------------------------------------------------------

  Future<void> _handleRotateBy(
    double degrees,
    int index,
    ScannerPage currentPage,
  ) async {
    setState(() => _isBusy = true);

    try {
      final newPath = await _buildEditPath(currentPage.id);
      await _imageProcessing.rotate(
        inputPath: currentPage.imagePath,
        outputPath: newPath,
        degrees: degrees,
      );
      final updated = currentPage.copyWith(
        imagePath: newPath,
        rotation: currentPage.rotation + degrees,
      );
      _pushUndo(currentPage);
      ref.read(scannerPagesProvider.notifier).replacePage(index, updated);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rotation failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  // ------------------------------------------------------------
  // Filters
  // ------------------------------------------------------------

  Future<void> _handleOpenFilterSheet(
    int index,
    ScannerPage currentPage,
  ) async {
    final selected = await showModalBottomSheet<ScanFilter>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (_) => ScannerEditorFilterSheet(
        currentFilter: _pendingFilter ?? currentPage.filter,
        onSelect: (f) => Navigator.of(context).pop(f),
      ),
    );

    if (selected == null) return;
    setState(() => _pendingFilter = selected);
  }

  // ------------------------------------------------------------
  // Adjustments
  // ------------------------------------------------------------

  void _handleOpenAdjustmentSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (_) => ScannerEditorAdjustmentSheet(
        initialBrightness: _pendingBrightness ?? 1.0,
        initialContrast: _pendingContrast ?? 1.0,
        initialSaturation: _pendingSaturation ?? 1.0,
        initialGamma: _pendingGamma ?? 1.0,
        onChanged: ({
          required double brightness,
          required double contrast,
          required double saturation,
          required double gamma,
        }) {
          setState(() {
            _pendingBrightness = brightness;
            _pendingContrast = contrast;
            _pendingSaturation = saturation;
            _pendingGamma = gamma;
          });
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // Fine rotate sheet
  // ------------------------------------------------------------

  Future<void> _handleOpenRotateSheet(
    int index,
    ScannerPage currentPage,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (_) => ScannerEditorRotateSheet(
        onApply: (angle) =>
            _handleRotateBy(angle, index, currentPage),
      ),
    );
  }

  // ------------------------------------------------------------
  // Undo / redo
  // ------------------------------------------------------------

  void _handleUndo(int index) {
    if (_undoStack.isEmpty) return;
    final previous = _undoStack.removeLast();
    final current = ref.read(scannerPagesProvider).pages[index];
    _redoStack.add(current);
    ref.read(scannerPagesProvider.notifier).replacePage(index, previous);
  }

  void _handleRedo(int index) {
    if (_redoStack.isEmpty) return;
    final next = _redoStack.removeLast();
    final current = ref.read(scannerPagesProvider).pages[index];
    _undoStack.add(current);
    ref.read(scannerPagesProvider.notifier).replacePage(index, next);
  }

  void _pushUndo(ScannerPage current) {
    _undoStack.add(current);
    _redoStack.clear();
  }

  // ------------------------------------------------------------
  // Retake
  // ------------------------------------------------------------

  Future<void> _handleRetake(int index) async {
    await ref.read(scannerPagesProvider.notifier).removePage(index);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  // ------------------------------------------------------------
  // Save
  // ------------------------------------------------------------

  Future<void> _handleSave(int index) async {
    setState(() => _isBusy = true);

    try {
      final current = ref.read(scannerPagesProvider).pages[index];
      var workingPath = current.imagePath;
      var workingPage = current;

      final hasFilter =
          _pendingFilter != null && _pendingFilter != current.filter;

      if (hasFilter) {
        final filterPath = await _buildEditPath(current.id);
        await _imageProcessing.applyFilter(
          inputPath: workingPath,
          outputPath: filterPath,
          filter: _pendingFilter!,
        );
        workingPath = filterPath;
        workingPage = workingPage.copyWith(
          imagePath: filterPath,
          filter: _pendingFilter!,
        );
      }

      final hasAdjustment = _pendingBrightness != null ||
          _pendingContrast != null ||
          _pendingSaturation != null ||
          _pendingGamma != null;

      if (hasAdjustment) {
        final adjustPath = await _buildEditPath(current.id);
        await _imageProcessing.adjust(
          inputPath: workingPath,
          outputPath: adjustPath,
          brightness: _pendingBrightness,
          contrast: _pendingContrast,
          saturation: _pendingSaturation,
          gamma: _pendingGamma,
        );
        workingPath = adjustPath;
        workingPage = workingPage.copyWith(imagePath: adjustPath);
      }

      if (hasFilter || hasAdjustment) {
        ref
            .read(scannerPagesProvider.notifier)
            .replacePage(index, workingPage);
      }

      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  // ------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------

  Future<String> _buildEditPath(String pageId) async {
    final base = await _storage.newPageImagePath(pageId);
    final suffix = DateTime.now().microsecondsSinceEpoch;
    final dot = base.lastIndexOf('.');
    if (dot == -1) {
      return '${base}_edit_$suffix.jpg';
    }
    final stem = base.substring(0, dot);
    final ext = base.substring(dot);
    return '${stem}_edit_$suffix$ext';
  }
}
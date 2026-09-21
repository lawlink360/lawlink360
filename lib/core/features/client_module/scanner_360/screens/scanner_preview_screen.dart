import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/scanner_page.dart';
import '../providers/scanner_pages_provider.dart';
import '../widgets/shared/scanner_empty_view.dart';
import 'scanner_editor_screen.dart';
import 'scanner_save_screen.dart';

/// Shows the most recently captured page before continuing.
class ScannerPreviewScreen extends ConsumerWidget {
  const ScannerPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerPagesProvider);

    if (state.pages.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textLight,
                  ),
                  tooltip: 'Back',
                ),
              ),
              Expanded(
                child: ScannerEmptyView(
                  icon: Icons.image_not_supported_outlined,
                  title: 'No page to preview',
                  subtitle: 'Return to the camera and capture a page.',
                  actionLabel: 'Back to camera',
                  onAction: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final index = state.activePageIndex.clamp(
      0,
      state.pages.length - 1,
    );
    final page = state.pages[index];

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: _PagePreview(page: page),
            ),
            Positioned(
              top: AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: _TopBar(
                onBack: () => _handleKeepAndContinue(context),
              ),
            ),
            Positioned(
              bottom: AppSpacing.lg,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              child: _BottomActions(
                onRetake: () => _handleRetake(context, ref, index),
                onEdit: () => _handleEdit(context),
                onDone: () => _handleDone(context),
                onKeepAndContinue: () =>
                    _handleKeepAndContinue(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleRetake(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    await ref.read(scannerPagesProvider.notifier).removePage(index);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _handleEdit(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerEditorScreen(),
      ),
    );
    if (result == true && context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleDone(BuildContext context) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerSaveScreen(),
      ),
    );
    if (result == true && context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  void _handleKeepAndContinue(BuildContext context) {
    Navigator.of(context).pop();
  }
}

// ============================================================
// Private widgets
// ============================================================

class _PagePreview extends StatelessWidget {
  const _PagePreview({required this.page});

  final ScannerPage page;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1.0,
      maxScale: 4.0,
      child: Center(
        child: Image.file(
          File(page.imagePath),
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) => const Center(
            child: Icon(
              Icons.broken_image_outlined,
              color: AppColors.textLight,
              size: AppSpacing.iconLg,
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textLight,
            size: AppSpacing.iconMd,
          ),
          tooltip: 'Back to camera',
        ),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.onRetake,
    required this.onEdit,
    required this.onDone,
    required this.onKeepAndContinue,
  });

  final VoidCallback onRetake;
  final VoidCallback onEdit;
  final VoidCallback onDone;
  final VoidCallback onKeepAndContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _PreviewAction(
              icon: Icons.refresh,
              label: 'Retake',
              onTap: onRetake,
            ),
            _PreviewAction(
              icon: Icons.tune,
              label: 'Edit',
              onTap: onEdit,
            ),
            _PreviewAction(
              icon: Icons.check_circle_outline,
              label: 'Done',
              onTap: onDone,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeight,
          child: ElevatedButton(
            onPressed: onKeepAndContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            child: const Text('Keep & Continue'),
          ),
        ),
      ],
    );
  }
}

class _PreviewAction extends StatelessWidget {
  const _PreviewAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.glassWhite,
              ),
              child: Icon(
                icon,
                color: AppColors.textLight,
                size: AppSpacing.iconMd,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
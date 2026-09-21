import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/scanner_page.dart';
import '../widgets/shared/scanner_empty_view.dart';

/// Full-screen image viewer for Scanner 360.
///
/// Displays the pages of a document. Swipe horizontally to move
/// between pages. Pinch or double-tap to zoom and pan. Does not
/// modify the saved pages.
class ScannerImageViewerScreen extends StatefulWidget {
  const ScannerImageViewerScreen({
    super.key,
    required this.pages,
    required this.initialIndex,
  });

  final List<ScannerPage> pages;
  final int initialIndex;

  @override
  State<ScannerImageViewerScreen> createState() =>
      _ScannerImageViewerScreenState();
}

class _ScannerImageViewerScreenState
    extends State<ScannerImageViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(
      0,
      widget.pages.isEmpty ? 0 : widget.pages.length - 1,
    );
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pages.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          elevation: 0,
          title: const Text('Page'),
        ),
        body: ScannerEmptyView(
          icon: Icons.image_not_supported_outlined,
          title: 'No page to display',
          subtitle: 'This document has no saved pages.',
          actionLabel: 'Back',
          onAction: () => Navigator.of(context).pop(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        title: Text(
          '${_currentIndex + 1} / ${widget.pages.length}',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.pages.length,
        onPageChanged: (index) => setState(() => _currentIndex = index),
        itemBuilder: (context, index) {
          final page = widget.pages[index];
          return InteractiveViewer(
            minScale: 1.0,
            maxScale: 5.0,
            child: Center(
              child: Image.file(
                File(page.imagePath),
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.lightTextSecondary,
                    size: AppSpacing.iconLg,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
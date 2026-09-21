import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_radius.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../providers/scanner_pages_provider.dart';

/// Reorderable list of pages.
class ScannerMultipageReorderList extends ConsumerWidget {
  const ScannerMultipageReorderList({
    super.key,
    required this.onPageTapped,
  });

  final void Function(int index) onPageTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerPagesProvider);

    if (state.pages.isEmpty) {
      return const Center(
        child: Text(
          'No pages to reorder.',
          style: AppTextStyles.bodySmall,
        ),
      );
    }

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.pages.length,
      onReorderItem: (oldIndex, newIndex) {
        ref
            .read(scannerPagesProvider.notifier)
            .reorderPages(oldIndex, newIndex);
      },
      itemBuilder: (context, index) {
        final page = state.pages[index];

        return Container(
          key: ValueKey(page.id),
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: index == state.activePageIndex
                  ? AppColors.accent
                  : AppColors.lightBorder,
              width: index == state.activePageIndex ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onPageTapped(index),
                child: SizedBox(
                  width: 48,
                  height: 64,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    child: Image.file(
                      File(page.imagePath),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.broken_image_outlined,
                        color: AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Page ${index + 1}',
                  style: AppTextStyles.body,
                ),
              ),
              const Icon(
                Icons.drag_handle,
                color: AppColors.lightTextSecondary,
              ),
            ],
          ),
        );
      },
    );
  }
}

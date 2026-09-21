import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_spacing.dart';
import '../../providers/scanner_pages_provider.dart';
import '../shared/scanner_empty_view.dart';
import 'scanner_multipage_thumbnail.dart';

/// Grid of page thumbnails.
class ScannerMultipageGrid extends ConsumerWidget {
  const ScannerMultipageGrid({
    super.key,
    required this.onPageTapped,
    required this.onPageLongPressed,
  });

  final void Function(int index) onPageTapped;
  final void Function(int index) onPageLongPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scannerPagesProvider);

    if (state.pages.isEmpty) {
      return const ScannerEmptyView(
        icon: Icons.description_outlined,
        title: 'No pages yet',
        subtitle: 'Capture a page to start building the document.',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.pages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final page = state.pages[index];
        return GestureDetector(
          onLongPress: () => onPageLongPressed(index),
          child: ScannerMultipageThumbnail(
            page: page,
            index: index,
            isActive: index == state.activePageIndex,
            onTap: () => onPageTapped(index),
          ),
        );
      },
    );
  }
}
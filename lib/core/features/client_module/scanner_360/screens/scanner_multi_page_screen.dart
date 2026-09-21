import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../providers/scanner_pages_provider.dart';
import '../widgets/multipage/scanner_multipage_bottom_bar.dart';
import '../widgets/multipage/scanner_multipage_grid.dart';
import '../widgets/multipage/scanner_multipage_reorder_list.dart';
import 'scanner_camera_screen.dart';
import 'scanner_save_screen.dart';

/// Multi-page workspace for Scanner 360.
class ScannerMultiPageScreen extends ConsumerStatefulWidget {
  const ScannerMultiPageScreen({super.key});

  @override
  ConsumerState<ScannerMultiPageScreen> createState() =>
      _ScannerMultiPageScreenState();
}

class _ScannerMultiPageScreenState
    extends ConsumerState<ScannerMultiPageScreen> {
  ScannerMultipageViewMode _mode = ScannerMultipageViewMode.grid;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerPagesProvider);
    final activeIndex = state.activePageIndex;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Pages'),
      ),
      body: _mode == ScannerMultipageViewMode.grid
          ? ScannerMultipageGrid(
              onPageTapped: _handleSetActive,
              onPageLongPressed: _handleSetActive,
            )
          : ScannerMultipageReorderList(
              onPageTapped: _handleSetActive,
            ),
      bottomNavigationBar: ScannerMultipageBottomBar(
        mode: _mode,
        onModeChanged: _handleModeChanged,
        onAddPage: _handleAddPage,
        onDeletePage: () => _handleDeleteActivePage(activeIndex),
        onDone: _handleDone,
        pageCount: state.pages.length,
      ),
    );
  }

  Future<void> _handleAddPage() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerCameraScreen(),
      ),
    );
    if (result == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _handleDeleteActivePage(int index) async {
    await ref.read(scannerPagesProvider.notifier).removePage(index);
  }

  void _handleSetActive(int index) {
    ref.read(scannerPagesProvider.notifier).setActivePage(index);
  }

  void _handleModeChanged(ScannerMultipageViewMode mode) {
    setState(() => _mode = mode);
  }

  Future<void> _handleDone() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => const ScannerSaveScreen(),
      ),
    );
    if (result == true && mounted) {
      Navigator.of(context).pop(true);
    }
  }
}
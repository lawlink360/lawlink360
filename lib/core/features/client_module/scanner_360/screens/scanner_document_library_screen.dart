import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/scanner_document.dart';
import '../providers/scanner_documents_provider.dart';
import '../widgets/library/scanner_library_card.dart';
import '../widgets/shared/scanner_empty_view.dart';
import '../widgets/shared/scanner_error_view.dart';
import '../widgets/shared/scanner_loading_overlay.dart';
import 'scanner_document_viewer_screen.dart';

/// Document Library for Scanner 360.
///
/// Displays all saved documents in a responsive 2-column grid and
/// supports search-as-typed via the existing documents provider.
class ScannerDocumentLibraryScreen extends ConsumerStatefulWidget {
  const ScannerDocumentLibraryScreen({super.key});

  @override
  ConsumerState<ScannerDocumentLibraryScreen> createState() =>
      _ScannerDocumentLibraryScreenState();
}

class _ScannerDocumentLibraryScreenState
    extends ConsumerState<ScannerDocumentLibraryScreen> {
  final TextEditingController _searchController =
      TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(scannerDocumentsProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scannerDocumentsProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        title: const Text('Documents'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _handleSearchChanged,
                textInputAction: TextInputAction.search,
                style: AppTextStyles.body,
                decoration: InputDecoration(
                  hintText: 'Search documents',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.lightTextSecondary,
                  ),
                  filled: true,
                  fillColor: AppColors.lightSurface,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(
                      color: AppColors.lightBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(
                      color: AppColors.lightBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  _buildBody(state),
                  state.isLoading
                      ? const ScannerLoadingOverlay(
                          label: 'Loading documents…',
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(AsyncValue<List<ScannerDocument>> state) {
    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => ScannerErrorView(
        title: 'Unable to load documents',
        message: e.toString(),
        onRetry: () =>
            ref.read(scannerDocumentsProvider.notifier).refresh(),
        retryLabel: 'Retry',
      ),
      data: (docs) {
        if (docs.isEmpty) {
          if (_query.trim().isEmpty) {
            return const ScannerEmptyView(
              icon: Icons.folder_outlined,
              title: 'No documents yet',
              subtitle: 'Your scanned documents will appear here.',
            );
          }
          return const ScannerEmptyView(
            icon: Icons.search_off,
            title: 'No matches',
            subtitle: 'Try a different search term.',
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: docs.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final doc = docs[index];
            return ScannerLibraryCard(
              document: doc,
              onTap: () => _handleOpenDocument(doc),
            );
          },
        );
      },
    );
  }

  void _handleSearchChanged(String value) {
    _query = value;
    ref.read(scannerDocumentsProvider.notifier).search(value);
  }

  void _handleOpenDocument(ScannerDocument document) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScannerDocumentViewerScreen(
          documentId: document.id,
        ),
      ),
    );
  }
}
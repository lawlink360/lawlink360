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
/// Displays saved documents in a responsive 2-column grid. Supports
/// search-as-typed via the existing documents provider, an AppBar
/// favourites filter that reuses the provider's favourite capability,
/// and per-document actions (favourite, rename, delete) surfaced
/// through a long-press bottom sheet.
///
/// Search and the favourites filter are mutually exclusive: enabling
/// one clears the other. Both reuse the existing provider methods;
/// no additional state or persistence is introduced.
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
  bool _favoritesOnly = false;

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
        actions: [
          IconButton(
            tooltip: _favoritesOnly
                ? 'Show all documents'
                : 'Show favourites',
            icon: Icon(
              _favoritesOnly ? Icons.star : Icons.star_border,
              color: _favoritesOnly
                  ? AppColors.accent
                  : AppColors.lightTextSecondary,
            ),
            onPressed: _handleToggleFavoritesFilter,
          ),
        ],
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
          if (_query.trim().isEmpty && !_favoritesOnly) {
            return const ScannerEmptyView(
              icon: Icons.folder_outlined,
              title: 'No documents yet',
              subtitle: 'Your scanned documents will appear here.',
            );
          }
          if (_favoritesOnly && _query.trim().isEmpty) {
            return const ScannerEmptyView(
              icon: Icons.star_border,
              title: 'No favourites yet',
              subtitle:
                  'Long-press a document and tap Favourite to add it here.',
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
              onLongPress: () => _handleOpenDocumentActions(doc),
              onToggleFavorite: () => _handleToggleFavorite(doc),
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Search + filter
  // ------------------------------------------------------------

  void _handleSearchChanged(String value) {
    setState(() {
      _query = value;
      if (value.trim().isNotEmpty) {
        _favoritesOnly = false;
      }
    });
    ref.read(scannerDocumentsProvider.notifier).search(value);
  }

  void _handleToggleFavoritesFilter() {
    final next = !_favoritesOnly;
    setState(() {
      _favoritesOnly = next;
      if (next) {
        _query = '';
        _searchController.clear();
      }
    });

    final notifier = ref.read(scannerDocumentsProvider.notifier);
    if (next) {
      notifier.loadFavorites();
    } else {
      notifier.refresh();
    }
  }

  // ------------------------------------------------------------
  // Navigation
  // ------------------------------------------------------------

  void _handleOpenDocument(ScannerDocument document) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ScannerDocumentViewerScreen(
          documentId: document.id,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Actions
  // ------------------------------------------------------------

  Future<void> _handleOpenDocumentActions(
    ScannerDocument document,
  ) async {
    final action = await showModalBottomSheet<_DocumentAction>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                document.metadata.isFavorite
                    ? Icons.star
                    : Icons.star_border,
                color: AppColors.accent,
              ),
              title: Text(
                document.metadata.isFavorite
                    ? 'Unfavourite'
                    : 'Favourite',
              ),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DocumentAction.toggleFavorite),
            ),
            ListTile(
              leading: const Icon(
                Icons.drive_file_rename_outline,
              ),
              title: const Text('Rename'),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DocumentAction.rename),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: AppColors.error,
              ),
              title: const Text('Delete'),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DocumentAction.delete),
            ),
          ],
        ),
      ),
    );

    if (!mounted || action == null) return;

    switch (action) {
      case _DocumentAction.toggleFavorite:
        await _handleToggleFavorite(document);
        break;
      case _DocumentAction.rename:
        await _handleRename(document);
        break;
      case _DocumentAction.delete:
        await _handleDelete(document);
        break;
    }
  }

  Future<void> _handleToggleFavorite(
    ScannerDocument document,
  ) async {
    final newValue = !document.metadata.isFavorite;
    final notifier = ref.read(scannerDocumentsProvider.notifier);
    try {
      await notifier.setFavorite(document.id, newValue);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to update favourite: $e');
      return;
    }

    if (!mounted) return;

    // The provider's setFavorite repopulates state from
    // getAllDocuments(). When the favourites filter is active, re-apply
    // loadFavorites() so the grid stays consistent, and drop the filter
    // automatically if no favourites remain.
    if (_favoritesOnly) {
      await notifier.loadFavorites();
      if (!mounted) return;
      final docs = ref
          .read(scannerDocumentsProvider)
          .valueOrNull;
      if (docs != null && docs.isEmpty) {
        setState(() => _favoritesOnly = false);
        await notifier.refresh();
      }
    }
  }

  Future<void> _handleRename(ScannerDocument document) async {
    final controller =
        TextEditingController(text: document.metadata.name);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Rename document'),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Document name',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              final trimmed = value.trim();
              if (trimmed.isEmpty) return;
              Navigator.of(dialogContext).pop(trimmed);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final trimmed = controller.text.trim();
                if (trimmed.isEmpty) return;
                Navigator.of(dialogContext).pop(trimmed);
              },
              child: const Text('Rename'),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (result == null || result.isEmpty) return;

    final notifier = ref.read(scannerDocumentsProvider.notifier);
    try {
      await notifier.renameDocument(document.id, result);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to rename: $e');
      return;
    }

    if (!mounted) return;

    if (_favoritesOnly) {
      await notifier.loadFavorites();
    }
  }

  Future<void> _handleDelete(ScannerDocument document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete document'),
          content: Text(
            'Delete "${document.metadata.name}"? '
            'This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.textLight,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    final notifier = ref.read(scannerDocumentsProvider.notifier);
    try {
      await notifier.deleteDocument(document.id);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to delete: $e');
      return;
    }

    if (!mounted) return;

    if (_favoritesOnly) {
      await notifier.loadFavorites();
      if (!mounted) return;
      final docs =
          ref.read(scannerDocumentsProvider).valueOrNull;
      if (docs != null && docs.isEmpty) {
        setState(() => _favoritesOnly = false);
        await notifier.refresh();
      }
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

enum _DocumentAction {
  toggleFavorite,
  rename,
  delete,
}
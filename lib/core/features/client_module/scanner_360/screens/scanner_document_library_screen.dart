import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../models/scanner_document.dart';
import '../models/scanner_folder.dart';
import '../providers/scanner_documents_provider.dart';
import '../services/scanner_storage_service.dart';
import '../widgets/library/scanner_library_card.dart';
import '../widgets/shared/scanner_empty_view.dart';
import '../widgets/shared/scanner_error_view.dart';
import '../widgets/shared/scanner_loading_overlay.dart';
import 'scanner_document_viewer_screen.dart';

/// Document Library for Scanner 360.
///
/// Y7.5 integrates the Y7.1 provider selection state with the Y7.4
/// card selection UI. The screen itself holds no selection state;
/// it reads `isSelectionMode`, `selectedDocumentIds`, and
/// `allVisibleSelected` from the provider and calls the provider's
/// `enterSelectionMode`, `toggleSelection`, `clearSelection`, and
/// `selectAllVisible` methods.
///
/// Bulk Move / Delete / Favourite are intentionally not wired in
/// this batch. The selection-mode AppBar exposes count, clear, and
/// Select All only.
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
      ref.read(scannerDocumentsProvider.notifier).goToRoot();
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
    final notifier = ref.read(scannerDocumentsProvider.notifier);
    final currentFolder = notifier.currentFolder;
    final isRoot = notifier.currentFolderId == null;
    final isSelectionMode = notifier.isSelectionMode;
    final selectedCount = notifier.selectedCount;

    return PopScope(
      canPop: isRoot && !isSelectionMode,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (isSelectionMode) {
          notifier.clearSelection();
          return;
        }
        notifier.goToParent();
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: isSelectionMode
            ? _buildSelectionAppBar(notifier, selectedCount, state)
            : _buildNormalAppBar(
                notifier,
                currentFolder,
                isRoot,
              ),
        body: SafeArea(
          child: Column(
            children: [
              if (!isSelectionMode)
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
                        borderRadius:
                            BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(
                          color: AppColors.lightBorder,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(
                          color: AppColors.lightBorder,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppRadius.md),
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
                    _buildBody(state, notifier),
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
      ),
    );
  }

  PreferredSizeWidget _buildNormalAppBar(
    ScannerDocumentsNotifier notifier,
    ScannerFolder? currentFolder,
    bool isRoot,
  ) {
    return AppBar(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      leading: isRoot
          ? null
          : IconButton(
              tooltip: 'Back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () => notifier.goToParent(),
            ),
      title: Text(currentFolder?.name ?? 'Documents'),
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
        if (_query.trim().isEmpty && !_favoritesOnly)
          IconButton(
            tooltip: 'New folder',
            icon: const Icon(Icons.create_new_folder_outlined),
            onPressed: _handleCreateFolder,
          ),
      ],
    );
  }

  PreferredSizeWidget _buildSelectionAppBar(
    ScannerDocumentsNotifier notifier,
    int selectedCount,
    AsyncValue<List<ScannerDocument>> state,
  ) {
    final visible = state.valueOrNull ?? const <ScannerDocument>[];
    final allSelected = notifier.allVisibleSelected(visible);
    final canSelectAll = visible.isNotEmpty && !allSelected;

    return AppBar(
      backgroundColor: AppColors.lightSurface,
      foregroundColor: AppColors.lightTextPrimary,
      elevation: 0,
      leading: IconButton(
        tooltip: 'Cancel selection',
        icon: const Icon(Icons.close),
        onPressed: () => notifier.clearSelection(),
      ),
      title: Text(
        selectedCount == 1
            ? '1 selected'
            : '$selectedCount selected',
      ),
      actions: [
        TextButton(
          onPressed: canSelectAll
              ? () => notifier.selectAllVisible(visible)
              : null,
          child: Text(
            'Select all',
            style: AppTextStyles.body.copyWith(
              color: canSelectAll
                  ? AppColors.primary
                  : AppColors.lightTextSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(
    AsyncValue<List<ScannerDocument>> state,
    ScannerDocumentsNotifier notifier,
  ) {
    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (e, _) => ScannerErrorView(
        title: 'Unable to load documents',
        message: e.toString(),
        onRetry: () => notifier.goToRoot(),
        retryLabel: 'Retry',
      ),
      data: (docs) {
        final folders = notifier.foldersInCurrentContext;
        final isSelectionMode = notifier.isSelectionMode;
        final selectedIds = notifier.selectedDocumentIds;

        if (docs.isEmpty && folders.isEmpty) {
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
                  'Use the overflow menu on a document and choose '
                  'Favourite to add it here.',
            );
          }
          return const ScannerEmptyView(
            icon: Icons.search_off,
            title: 'No matches',
            subtitle: 'Try a different search term.',
          );
        }

        return CustomScrollView(
          slivers: [
            if (!isSelectionMode && folders.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xs,
                ),
                sliver: SliverToBoxAdapter(
                  child: _SectionLabel(text: 'Folders'),
                ),
              ),
            if (!isSelectionMode && folders.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final folder = folders[index];
                      return _FolderRow(
                        folder: folder,
                        onTap: () => notifier.goToFolder(folder.id),
                        onRename: () => _handleRenameFolder(folder),
                        onDelete: () => _handleDeleteFolder(folder),
                      );
                    },
                    childCount: folders.length,
                  ),
                ),
              ),
            if (docs.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xs,
                ),
                sliver: SliverToBoxAdapter(
                  child: _SectionLabel(text: 'Documents'),
                ),
              ),
            if (docs.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final doc = docs[index];
                      return ScannerLibraryCard(
                        document: doc,
                        isSelectionMode: isSelectionMode,
                        isSelected: selectedIds.contains(doc.id),
                        onToggleSelection: () =>
                            notifier.toggleSelection(doc.id),
                        onTap: () => _handleOpenDocument(doc),
                        onLongPress: () =>
                            notifier.enterSelectionMode(doc.id),
                        onToggleFavorite: () =>
                            _handleToggleFavorite(doc),
                        onOpenActions: () =>
                            _handleOpenDocumentActions(doc),
                      );
                    },
                    childCount: docs.length,
                  ),
                ),
              ),
          ],
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
  // Folder mutations (Y4)
  // ------------------------------------------------------------

  Future<void> _handleCreateFolder() async {
    final name = await _showFolderNameDialog(
      title: 'New folder',
      confirmLabel: 'Create',
      initialValue: '',
    );
    if (name == null) return;

    final notifier = ref.read(scannerDocumentsProvider.notifier);
    try {
      await notifier.createFolder(name);
      if (!mounted) return;
      _showSnackBar('Folder created');
    } on ScannerFolderRuleException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to create folder: $e');
    }
  }

  Future<void> _handleRenameFolder(ScannerFolder folder) async {
    final name = await _showFolderNameDialog(
      title: 'Rename folder',
      confirmLabel: 'Rename',
      initialValue: folder.name,
    );
    if (name == null) return;

    final notifier = ref.read(scannerDocumentsProvider.notifier);
    try {
      await notifier.renameFolder(folder.id, name);
      if (!mounted) return;
      _showSnackBar('Folder renamed');
    } on ScannerFolderRuleException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to rename folder: $e');
    }
  }

  Future<void> _handleDeleteFolder(ScannerFolder folder) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete folder'),
          content: Text(
            'Delete "${folder.name}"? '
            'Documents in this folder will be moved to the parent '
            'folder. This cannot be undone.',
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
      await notifier.deleteFolder(folder.id);
      if (!mounted) return;
      _showSnackBar('Folder deleted');
    } on ScannerFolderRuleException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to delete folder: $e');
    }
  }

  Future<String?> _showFolderNameDialog({
    required String title,
    required String confirmLabel,
    required String initialValue,
  }) async {
    final controller = TextEditingController(text: initialValue);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Folder name',
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
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );

    if (result == null || result.isEmpty) return null;
    return result;
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
  // Document actions
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
              leading: const Icon(Icons.drive_file_move_outline),
              title: const Text('Move'),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DocumentAction.move),
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
              leading: const Icon(Icons.copy_all_outlined),
              title: const Text('Duplicate'),
              onTap: () => Navigator.of(sheetContext)
                  .pop(_DocumentAction.duplicate),
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
      case _DocumentAction.move:
        await _handleMoveDocument(document);
        break;
      case _DocumentAction.rename:
        await _handleRename(document);
        break;
      case _DocumentAction.duplicate:
        await _handleDuplicateDocument(document);
        break;
      case _DocumentAction.delete:
        await _handleDelete(document);
        break;
    }
  }

  Future<void> _handleDuplicateDocument(
    ScannerDocument document,
  ) async {
    final notifier = ref.read(scannerDocumentsProvider.notifier);
    try {
      await notifier.duplicateDocument(document.id);
      if (!mounted) return;
      _showSnackBar('Document duplicated');
    } on ScannerFolderRuleException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message);
    } on ScannerSourceAssetMissingException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to duplicate document: $e');
    }
  }

  Future<void> _handleMoveDocument(ScannerDocument document) async {
    final notifier = ref.read(scannerDocumentsProvider.notifier);
    final allFolders = notifier.allFolders;

    final destination = await showModalBottomSheet<_MoveDestination>(
      context: context,
      backgroundColor: AppColors.lightSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.lg),
        ),
      ),
      builder: (sheetContext) {
        final currentFolderId = document.metadata.folderId;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Move to'),
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _MoveDestinationTile(
                      label: 'Root',
                      isCurrent: currentFolderId == null,
                      onTap: () => Navigator.of(sheetContext).pop(
                        const _MoveDestination(null),
                      ),
                    ),
                    for (final f in allFolders)
                      _MoveDestinationTile(
                        label: f.name,
                        isCurrent: f.id == currentFolderId,
                        onTap: () => Navigator.of(sheetContext).pop(
                          _MoveDestination(f.id),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || destination == null) return;

    if (destination.folderId == document.metadata.folderId) {
      return;
    }

    try {
      await notifier.moveDocument(
        document.id,
        destination.folderId,
      );
      if (!mounted) return;
      _showSnackBar('Document moved');
    } on ScannerFolderRuleException catch (e) {
      if (!mounted) return;
      _showSnackBar(e.message);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar('Failed to move document: $e');
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

    if (_favoritesOnly) {
      await notifier.loadFavorites();
      if (!mounted) return;
      final docs = ref.read(scannerDocumentsProvider).valueOrNull;
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
      final docs = ref.read(scannerDocumentsProvider).valueOrNull;
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
  move,
  rename,
  duplicate,
  delete,
}

class _MoveDestination {
  const _MoveDestination(this.folderId);
  final String? folderId;
}

class _MoveDestinationTile extends StatelessWidget {
  const _MoveDestinationTile({
    required this.label,
    required this.isCurrent,
    required this.onTap,
  });

  final String label;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isCurrent ? Icons.check : Icons.folder_outlined,
        color: isCurrent
            ? AppColors.primary
            : AppColors.lightTextSecondary,
      ),
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: AppColors.lightTextPrimary,
          fontWeight:
              isCurrent ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      enabled: !isCurrent,
      onTap: isCurrent ? null : onTap,
    );
  }
}

// ============================================================
// Folder-navigation presentation widgets (Y3/Y4)
// ============================================================

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.title.copyWith(
        color: AppColors.lightTextPrimary,
      ),
    );
  }
}

class _FolderRow extends StatelessWidget {
  const _FolderRow({
    required this.folder,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
  });

  final ScannerFolder folder;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.lightBorder),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder_outlined,
                  color: AppColors.primary,
                  size: AppSpacing.iconMd,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    folder.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                ),
                PopupMenuButton<_FolderAction>(
                  tooltip: 'Folder actions',
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.lightTextSecondary,
                  ),
                  onSelected: (action) {
                    switch (action) {
                      case _FolderAction.rename:
                        onRename();
                        break;
                      case _FolderAction.delete:
                        onDelete();
                        break;
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem<_FolderAction>(
                      value: _FolderAction.rename,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.drive_file_rename_outline,
                        ),
                        title: Text('Rename'),
                      ),
                    ),
                    PopupMenuItem<_FolderAction>(
                      value: _FolderAction.delete,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _FolderAction {
  rename,
  delete,
}
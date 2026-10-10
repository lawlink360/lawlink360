import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/document_template.dart';
import '../providers/application_recent_documents_provider.dart';
import '../services/document_data_service.dart';
import '../services/document_json_service.dart';
import 'document_preview_screen.dart';

/// ============================================================
/// RECENT DOCUMENTS SCREEN
/// ============================================================
///
/// Dedicated screen showing the full persisted recent-document
/// history (up to the service's max of 50 entries).
///
/// Reuses:
///   - the existing [recentDocumentsProvider];
///   - the existing template-resolution source
///     (DocumentJsonService / DocumentDataService);
///   - the existing [DocumentPreviewScreen] for opening a document.
///
/// Adds:
///   - a "Select" entry point in the AppBar;
///   - selection mode with per-item checkboxes;
///   - a selected count;
///   - multi-delete with confirmation;
///   - persistence of the deletion through the provider.
///
/// Deletion removes ONLY recent-document history records. It does
/// not delete templates, template content, or user document data.
/// ============================================================

class RecentDocumentsScreen extends ConsumerStatefulWidget {
  const RecentDocumentsScreen({super.key});

  @override
  ConsumerState<RecentDocumentsScreen> createState() =>
      _RecentDocumentsScreenState();
}

class _RecentDocumentsScreenState
    extends ConsumerState<RecentDocumentsScreen> {
  bool _isSelectMode = false;
  final Set<String> _selectedIds = <String>{};

  void _enterSelectMode() {
    setState(() {
      _isSelectMode = true;
      _selectedIds.clear();
    });
  }

  void _exitSelectMode() {
    setState(() {
      _isSelectMode = false;
      _selectedIds.clear();
    });
  }

  void _toggleSelection(String templateId) {
    setState(() {
      if (_selectedIds.contains(templateId)) {
        _selectedIds.remove(templateId);
      } else {
        _selectedIds.add(templateId);
      }
    });
  }

  Future<void> _confirmAndDelete() async {
    if (_selectedIds.isEmpty) return;

    final count = _selectedIds.length;
    final idsToDelete = Set<String>.from(_selectedIds);

    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Remove from Recent Documents?'),
          content: Text(
            count == 1
                ? 'This will remove 1 document from your recent-document history. The document itself will not be deleted.'
                : 'This will remove $count documents from your recent-document history. The documents themselves will not be deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;
    if (!mounted) return;

    ref
        .read(recentDocumentsProvider.notifier)
        .deleteEntries(idsToDelete);

    setState(() {
      _isSelectMode = false;
      _selectedIds.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final recentEntries = ref.watch(recentDocumentsProvider);

    // Resolve entries -> templates, silently skipping stale IDs.
    final resolved = <DocumentTemplate>[];
    for (final entry in recentEntries) {
      final template = _findTemplateById(entry.templateId);
      if (template != null) resolved.add(template);
    }

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        leading: _isSelectMode
            ? IconButton(
                tooltip: 'Cancel selection',
                icon: const Icon(Icons.close_rounded),
                onPressed: _exitSelectMode,
              )
            : null,
        title: Text(
          _isSelectMode
              ? '${_selectedIds.length} Selected'
              : 'Recent Documents',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        actions: [
          if (!_isSelectMode)
            TextButton(
              onPressed: resolved.isEmpty ? null : _enterSelectMode,
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
              ),
              child: Text(
                'Select',
                style: AppTextStyles.bodySmall.copyWith(
                  color: resolved.isEmpty
                      ? colorScheme.onSurface.withValues(alpha: 0.38)
                      : colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else
            IconButton(
              tooltip: 'Delete selected',
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed:
                  _selectedIds.isEmpty ? null : _confirmAndDelete,
            ),
        ],
      ),
      body: resolved.isEmpty
          ? const _RecentDocumentsScreenEmptyState()
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.xl,
              ),
              itemCount: resolved.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final template = resolved[index];
                final isSelected =
                    _selectedIds.contains(template.id);

                return _RecentDocumentsScreenTile(
                  template: template,
                  isSelectMode: _isSelectMode,
                  isSelected: isSelected,
                  onTap: _isSelectMode
                      ? () => _toggleSelection(template.id)
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DocumentPreviewScreen(
                                template: template,
                              ),
                            ),
                          );
                        },
                );
              },
            ),
    );
  }

  /// Resolves a stored templateId against the active catalogue.
  ///
  /// Mirrors the resolution strategy used on the Home screen so
  /// the two surfaces stay consistent.
  DocumentTemplate? _findTemplateById(String templateId) {
    final source = DocumentJsonService.loaded
        ? DocumentJsonService.templates
        : DocumentDataService.templates;

    for (final template in source) {
      if (template.id == templateId) return template;
    }
    return null;
  }
}

/// ============================================================
/// TILE
/// ============================================================

class _RecentDocumentsScreenTile extends StatelessWidget {
  final DocumentTemplate template;
  final bool isSelectMode;
  final bool isSelected;
  final VoidCallback onTap;

  const _RecentDocumentsScreenTile({
    required this.template,
    required this.isSelectMode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant.withValues(alpha: 0.55),
              width: isSelected ? 1.4 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              if (isSelectMode) ...[
                _SelectionIndicator(isSelected: isSelected),
                const SizedBox(width: AppSpacing.sm),
              ],
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: template.color.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: template.color.withValues(alpha: 0.16),
                  ),
                ),
                child: Icon(
                  template.icon,
                  color: template.color,
                  size: 23,
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Recent document',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurface
                            .withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              if (!isSelectMode)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: colorScheme.onSurface.withValues(alpha: 0.42),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const _SelectionIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.55),
          width: 1.6,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check_rounded,
              size: 16,
              color: colorScheme.onPrimary,
            )
          : null,
    );
  }
}

/// ============================================================
/// EMPTY STATE
/// ============================================================

class _RecentDocumentsScreenEmptyState extends StatelessWidget {
  const _RecentDocumentsScreenEmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color:
                  colorScheme.outlineVariant.withValues(alpha: 0.55),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  color:
                      colorScheme.onSurface.withValues(alpha: 0.55),
                  size: 23,
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No recent documents yet',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Documents you open or prepare will appear here.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurface
                            .withValues(alpha: 0.62),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
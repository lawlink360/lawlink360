import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_category.dart';
import '../../models/document_subcategory.dart';
import '../../models/document_template.dart';
import '../../screens/application_category_screen.dart';
import '../../screens/document_preview_screen.dart';
import '../../services/document_data_service.dart';
import '../../services/document_json_service.dart';

class ApplicationSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const ApplicationSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  State<ApplicationSearchBar> createState() =>
      _ApplicationSearchBarState();
}

class _ApplicationSearchBarState extends State<ApplicationSearchBar> {
  late final TextEditingController _internalController;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  /// Guards against repeated post-frame retries stacking up. A retry
  /// is scheduled at most once per frame while the field remains
  /// focused.
  bool _overlayRetryScheduled = false;

  /// Cycles the animated hint through the active category list while
  /// the field is empty.
  Timer? _hintTimer;
  int _hintIndex = 0;

  TextEditingController get _controller =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _internalController = TextEditingController();
    }

    _controller.addListener(_handleTextChanged);
    _focusNode.addListener(_handleFocusChanged);

    _startHintTimer();
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    _hintTimer = null;

    _controller.removeListener(_handleTextChanged);
    _focusNode.removeListener(_handleFocusChanged);
    _removeOverlay();

    if (widget.controller == null) {
      _internalController.dispose();
    }

    _focusNode.dispose();
    super.dispose();
  }

  // ============================================================
  // DATA SOURCE
  // ============================================================

  /// True when the JSON catalogue is loaded AND contains at least
  /// one category. An empty or partially-loaded JSON state must not
  /// hide the valid static fallback catalogue.
  bool get _useJsonCatalogue =>
      DocumentJsonService.loaded &&
      DocumentJsonService.getCategories().isNotEmpty;

  List<DocumentCategory> get _categories => _useJsonCatalogue
      ? DocumentJsonService.getCategories()
      : DocumentDataService.categories;

  /// Complete template list from the active catalogue. Used by the
  /// global template search — it does NOT walk the category /
  /// subcategory tree.
  List<DocumentTemplate> get _allTemplates => _useJsonCatalogue
      ? DocumentJsonService.templates
      : DocumentDataService.templates;

  DocumentSubCategory? _findSubCategory(String id) {
    if (_useJsonCatalogue) {
      for (final s in DocumentJsonService.subCategories) {
        if (s.id == id) return s;
      }
      return null;
    }
    for (final s in DocumentDataService.subCategories) {
      if (s.id == id) return s;
    }
    return null;
  }

  DocumentCategory? _findCategory(String id) {
    if (_useJsonCatalogue) {
      for (final c in DocumentJsonService.categories) {
        if (c.id == id) return c;
      }
      return null;
    }
    for (final c in DocumentDataService.categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  // ============================================================
  // ANIMATED HINT
  // ============================================================

  void _startHintTimer() {
    _hintTimer?.cancel();
    _hintTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        final categories = _categories;
        if (categories.isEmpty) return;

        setState(() {
          _hintIndex = (_hintIndex + 1) % categories.length;
        });
      },
    );
  }

  /// Current hint text. Returns the animated category prompt when at
  /// least one category is available; otherwise the existing static
  /// fallback so the field never shows an empty hint.
  String get _hintText {
    final categories = _categories;
    if (categories.isEmpty) {
      return 'What document do you need today?';
    }
    final index = _hintIndex % categories.length;
    return 'Search ${categories[index].title}';
  }

  // ============================================================
  // SEARCH
  // ============================================================

  /// Global template search across the complete active catalogue.
  ///
  /// Iterates the full template list directly (no reliance on a
  /// perfect category → subcategory tree). Each template is matched
  /// on its own title/description/body, and — as additional context
  /// — on the titles/descriptions of its resolved subcategory and
  /// category. A failure to resolve either parent does NOT exclude
  /// the template from matching on its own fields.
  List<_TemplateSearchResult> _searchTemplates(String rawQuery) {
    final query = rawQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return const [];
    }

    final results = <_TemplateSearchResult>[];

    for (final template in _allTemplates) {
      final templateMatches =
          template.title.toLowerCase().contains(query) ||
              template.description.toLowerCase().contains(query) ||
              template.body.toLowerCase().contains(query);

      // Resolve parent context. Either may be null; both null is
      // acceptable — the template is still evaluated on its own.
      final subCategory =
          _findSubCategory(template.subCategoryId);
      final category = subCategory == null
          ? null
          : _findCategory(subCategory.categoryId);

      final subCategoryMatches = subCategory != null &&
          (subCategory.title.toLowerCase().contains(query) ||
              subCategory.description.toLowerCase().contains(query));

      final categoryMatches = category != null &&
          (category.title.toLowerCase().contains(query) ||
              category.description.toLowerCase().contains(query));

      if (templateMatches || subCategoryMatches || categoryMatches) {
        results.add(
          _TemplateSearchResult(
            template: template,
            category: category,
            subCategory: subCategory,
          ),
        );
      }
    }

    return results;
  }

  // ============================================================
  // LIFECYCLE HOOKS
  // ============================================================

  void _handleTextChanged() {
    widget.onChanged?.call(_controller.text);

    if (mounted) {
      setState(() {});
    }

    _syncOverlay();
  }

  void _handleFocusChanged() {
    if (mounted) {
      setState(() {});
    }

    _syncOverlay();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');

    if (mounted) {
      setState(() {});
    }

    _syncOverlay();
  }

  // ============================================================
  // NAVIGATION
  // ============================================================

  void _openCategory(DocumentCategory category) {
    _focusNode.unfocus();
    _removeOverlay();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ApplicationCategoryScreen(
          category: category,
        ),
      ),
    );
  }

  void _openTemplate(DocumentTemplate template) {
    _focusNode.unfocus();
    _removeOverlay();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DocumentPreviewScreen(
          template: template,
        ),
      ),
    );
  }

  // ============================================================
  // OVERLAY
  // ============================================================

  void _syncOverlay() {
    final shouldShow = _focusNode.hasFocus;

    if (shouldShow) {
      if (_overlayEntry == null) {
        _scheduleOverlayInsertion();
      } else {
        _overlayEntry!.markNeedsBuild();
      }
    } else {
      _removeOverlay();
    }
  }

  /// Schedules an attempt to insert the overlay. If the Overlay is
  /// not yet available (e.g. the first post-frame callback ran too
  /// early), retry on the next frame while the field remains
  /// focused and the widget remains mounted.
  void _scheduleOverlayInsertion() {
    if (_overlayRetryScheduled) return;
    _overlayRetryScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayRetryScheduled = false;

      if (!mounted) return;
      if (!_focusNode.hasFocus) return;
      if (_overlayEntry != null) return;

      _insertOverlay();

      // If insertion still did not succeed (Overlay unavailable),
      // schedule another retry for the next frame. Bounded by
      // focus/mount and by the existence of _overlayEntry.
      if (_overlayEntry == null && mounted && _focusNode.hasFocus) {
        _scheduleOverlayInsertion();
      }
    });
  }

  void _insertOverlay() {
    final overlay = Overlay.maybeOf(context);

    if (overlay == null) {
      return;
    }

    final panelWidth =
        MediaQuery.of(context).size.width - (AppSpacing.md * 2);

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return Positioned(
          left: 0,
          top: 0,
          width: panelWidth,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, AppSpacing.buttonHeight - 4),
            child: _ResultsPanel(
              query: _controller.text,
              categories: _categories,
              templateResults: _searchTemplates(_controller.text),
              onCategorySelected: _openCategory,
              onTemplateSelected: _openTemplate,
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.65),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            cursorColor: AppColors.accent,
            onTapOutside: (_) {
              _focusNode.unfocus();
            },
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.48),
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: colorScheme.primary,
                size: 23,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: _clearSearch,
                      tooltip: 'Clear search',
                      icon: Icon(
                        Icons.close_rounded,
                        color: colorScheme.onSurface
                            .withValues(alpha: 0.55),
                      ),
                    )
                  : null,
              filled: false,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.md,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PRIVATE RESULT MODEL
// ============================================================

class _TemplateSearchResult {
  final DocumentTemplate template;
  final DocumentCategory? category;
  final DocumentSubCategory? subCategory;

  const _TemplateSearchResult({
    required this.template,
    required this.category,
    required this.subCategory,
  });
}

// ============================================================
// RESULTS PANEL
// ============================================================

class _ResultsPanel extends StatelessWidget {
  final String query;
  final List<DocumentCategory> categories;
  final List<_TemplateSearchResult> templateResults;
  final ValueChanged<DocumentCategory> onCategorySelected;
  final ValueChanged<DocumentTemplate> onTemplateSelected;

  const _ResultsPanel({
    required this.query,
    required this.categories,
    required this.templateResults,
    required this.onCategorySelected,
    required this.onTemplateSelected,
  });

  bool get _isCategoryState => query.trim().isEmpty;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final panelWidth =
        MediaQuery.of(context).size.width - (AppSpacing.md * 2);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: panelWidth,
        constraints: const BoxConstraints(
          maxHeight: 360,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.65),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: _isCategoryState
            ? _buildCategoryList(context)
            : _buildTemplateList(context),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (categories.isEmpty) {
      return const _EmptyPanelState(
        title: 'No categories available',
        subtitle: 'Categories could not be loaded.',
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
      ),
      itemCount: categories.length,
      separatorBuilder: (_, _) => Divider(
        height: 1,
        thickness: 1,
        color: colorScheme.outlineVariant.withValues(alpha: 0.35),
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return _CategoryResultTile(
          category: category,
          onTap: () => onCategorySelected(category),
        );
      },
    );
  }

  Widget _buildTemplateList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (templateResults.isEmpty) {
      return const _EmptyPanelState(
        title: 'No matching templates found',
        subtitle: 'Try a different document name or keyword.',
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.xs,
      ),
      itemCount: templateResults.length,
      separatorBuilder: (_, _) => Divider(
        height: 1,
        thickness: 1,
        color: colorScheme.outlineVariant.withValues(alpha: 0.35),
      ),
      itemBuilder: (context, index) {
        final result = templateResults[index];

        return _TemplateResultTile(
          result: result,
          onTap: () => onTemplateSelected(result.template),
        );
      },
    );
  }
}

// ============================================================
// CATEGORY RESULT TILE
// ============================================================

class _CategoryResultTile extends StatelessWidget {
  final DocumentCategory category;
  final VoidCallback onTap;

  const _CategoryResultTile({
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: category.color.withValues(alpha: 0.11),
                shape: BoxShape.circle,
                border: Border.all(
                  color: category.color.withValues(alpha: 0.16),
                ),
              ),
              child: Icon(
                category.icon,
                color: category.color,
                size: 20,
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            Expanded(
              child: Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.42),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TEMPLATE RESULT TILE
// ============================================================

class _TemplateResultTile extends StatelessWidget {
  final _TemplateSearchResult result;
  final VoidCallback onTap;

  const _TemplateResultTile({
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final template = result.template;

    final categoryTitle = result.category?.title;
    final subCategoryTitle = result.subCategory?.title;

    final breadcrumb = (categoryTitle != null && subCategoryTitle != null)
        ? '$categoryTitle \u2192 $subCategoryTitle'
        : (subCategoryTitle ?? categoryTitle ?? '');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: template.color.withValues(alpha: 0.11),
                shape: BoxShape.circle,
                border: Border.all(
                  color: template.color.withValues(alpha: 0.16),
                ),
              ),
              child: Icon(
                template.icon,
                color: template.color,
                size: 20,
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

                  if (breadcrumb.isNotEmpty) ...[
                    const SizedBox(height: 2),

                    Text(
                      breadcrumb,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurface
                            .withValues(alpha: 0.62),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: colorScheme.onSurface.withValues(alpha: 0.42),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// EMPTY PANEL STATE
// ============================================================

class _EmptyPanelState extends StatelessWidget {
  final String title;
  final String subtitle;

  const _EmptyPanelState({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              color: colorScheme.onSurface.withValues(alpha: 0.55),
              size: 20,
            ),
          ),

          const SizedBox(width: AppSpacing.sm),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurface
                        .withValues(alpha: 0.62),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
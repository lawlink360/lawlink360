import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/lawyer_model.dart';
import '../providers/lawyer_provider.dart';
import '../providers/lawyer_search_provider.dart';
import '../widgets/lawyer_card.dart';

class CategoryLawyersScreen extends ConsumerStatefulWidget {
  final String category;

  const CategoryLawyersScreen({super.key, required this.category});

  @override
  ConsumerState<CategoryLawyersScreen> createState() =>
      _CategoryLawyersScreenState();
}

class _CategoryLawyersScreenState extends ConsumerState<CategoryLawyersScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ref.read(lawyerSearchProvider.notifier).clearFilters();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _updateSearch(String query) {
    ref.read(lawyerSearchProvider.notifier).setSearchQuery(query);

    setState(() {});
  }

  void _endSearch() {
    _searchFocusNode.unfocus();
  }

  List<Lawyer> _filterCategoryLawyers(List<Lawyer> lawyers) {
    final searchNotifier = ref.read(lawyerSearchProvider.notifier);

    final categoryLawyers = lawyers.where(
      (lawyer) =>
          searchNotifier.matchesPracticeAreaForLawyer(lawyer, widget.category),
    );

    return searchNotifier.filterLawyers(categoryLawyers.toList());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final directoryAsync = ref.watch(lawyerDirectoryProvider);
    final searchState = ref.watch(lawyerSearchProvider);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _endSearch,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colorScheme.onSurface,
            ),
            tooltip: 'Back',
          ),
          title: Text(
            widget.category,
            style: AppTextStyles.title.copyWith(color: colorScheme.onSurface),
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: directoryAsync.when(
            loading: () => const _LoadingView(),
            error: (error, stackTrace) => const _ErrorView(),
            data: (lawyers) {
              final filteredLawyers = _filterCategoryLawyers(lawyers);

              final sortedLawyers = [...filteredLawyers]
                ..sort((a, b) => b.rating.compareTo(a.rating));

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.lg,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${sortedLawyers.length} '
                          '${sortedLawyers.length == 1 ? 'lawyer' : 'lawyers'} available',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _SearchField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          category: widget.category,
                          hasQuery: searchState.searchQuery.isNotEmpty,
                          onChanged: _updateSearch,
                          onClear: () {
                            _searchController.clear();
                            _updateSearch('');
                            _searchFocusNode.requestFocus();
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _QuickFilters(
                          state: searchState,
                          onFreeConsultation: () {
                            ref
                                .read(lawyerSearchProvider.notifier)
                                .toggleFreeConsultation();
                          },
                          onFeeUnder1500: () {
                            ref
                                .read(lawyerSearchProvider.notifier)
                                .toggleFeeUnder1500();
                          },
                          onFemaleLawyer: () {
                            ref
                                .read(lawyerSearchProvider.notifier)
                                .toggleFemaleLawyer();
                          },
                          onAvailableLawyer: () {
                            ref
                                .read(lawyerSearchProvider.notifier)
                                .toggleAvailableLawyer();
                          },
                          onInstantConsultation: () {
                            ref
                                .read(lawyerSearchProvider.notifier)
                                .toggleInstantConsultation();
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _RowFilters(
                          selectedCourtLevel: searchState.selectedCourtLevel,
                          minimumExperience: searchState.minimumExperience,
                          onCourtLevelChanged: _setCourtLevel,
                          onExperienceChanged: _setExperience,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                  Expanded(
                    child: sortedLawyers.isEmpty
                        ? const _EmptyView()
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.md,
                              AppSpacing.lg,
                              AppSpacing.xxl,
                            ),
                            itemCount: sortedLawyers.length,
                            itemBuilder: (context, index) {
                              return LawyerCard(lawyer: sortedLawyers[index]);
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _setCourtLevel(String level) {
    ref.read(lawyerSearchProvider.notifier).setCourtLevel(level);
  }

  void _setExperience(int? years) {
    ref.read(lawyerSearchProvider.notifier).setMinimumExperience(years);
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String category;
  final bool hasQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.category,
    required this.hasQuery,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      decoration: InputDecoration(
        hintText: 'Search $category lawyers',
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(Icons.search_rounded, color: colorScheme.primary),
        suffixIcon: hasQuery
            ? IconButton(
                onPressed: onClear,
                icon: Icon(
                  Icons.close_rounded,
                  color: colorScheme.onSurfaceVariant,
                ),
                tooltip: 'Clear search',
              )
            : null,
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.25),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      ),
    );
  }
}

class _QuickFilters extends StatelessWidget {
  final LawyerSearchState state;
  final VoidCallback onFreeConsultation;
  final VoidCallback onFeeUnder1500;
  final VoidCallback onFemaleLawyer;
  final VoidCallback onAvailableLawyer;
  final VoidCallback onInstantConsultation;

  const _QuickFilters({
    required this.state,
    required this.onFreeConsultation,
    required this.onFeeUnder1500,
    required this.onFemaleLawyer,
    required this.onAvailableLawyer,
    required this.onInstantConsultation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _QuickFilterChip(
            label: 'Free Consultation',
            selected: state.freeConsultation,
            onTap: onFreeConsultation,
          ),
          _QuickFilterChip(
            label: 'Fee Under 1500',
            selected: state.feeUnder1500,
            onTap: onFeeUnder1500,
          ),
          _QuickFilterChip(
            label: 'Female Lawyer',
            selected: state.femaleLawyer,
            onTap: onFemaleLawyer,
          ),
          _QuickFilterChip(
            label: 'Available Lawyer',
            selected: state.availableLawyer,
            onTap: onAvailableLawyer,
          ),
          _QuickFilterChip(
            label: 'Instant Consultation',
            selected: state.instantConsultation,
            onTap: onInstantConsultation,
          ),
        ],
      ),
    );
  }
}

class _QuickFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _QuickFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        labelStyle: AppTextStyles.bodySmall.copyWith(
          color: selected ? colorScheme.onPrimary : colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.55,
        ),
        selectedColor: colorScheme.primary,
        checkmarkColor: colorScheme.onPrimary,
        side: BorderSide(
          color: selected
              ? colorScheme.primary
              : colorScheme.outline.withValues(alpha: 0.25),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
      ),
    );
  }
}

class _RowFilters extends StatelessWidget {
  final String selectedCourtLevel;
  final int? minimumExperience;
  final ValueChanged<String> onCourtLevelChanged;
  final ValueChanged<int?> onExperienceChanged;

  const _RowFilters({
    required this.selectedCourtLevel,
    required this.minimumExperience,
    required this.onCourtLevelChanged,
    required this.onExperienceChanged,
  });

  String get _courtLevelLabel {
    switch (selectedCourtLevel) {
      case 'lower':
        return 'Lower Court';
      case 'high':
        return 'High Court';
      case 'supreme':
        return 'Supreme Court';
      default:
        return 'Court Level';
    }
  }

  String get _experienceLabel {
    switch (minimumExperience) {
      case 3:
        return '3+ Years';
      case 5:
        return '5+ Years';
      case 10:
        return '10+ Years';
      default:
        return 'Experience';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DropdownFilterButton(
            label: _courtLevelLabel,
            isSelected: selectedCourtLevel != 'All',
            onTap: () => _showCourtLevelMenu(context),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _DropdownFilterButton(
            label: _experienceLabel,
            isSelected: minimumExperience != null,
            onTap: () => _showExperienceMenu(context),
          ),
        ),
      ],
    );
  }

  void _showCourtLevelMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FilterOptionTile(
                  label: 'All Court Levels',
                  selected: selectedCourtLevel == 'All',
                  onTap: () {
                    onCourtLevelChanged('All');
                    Navigator.pop(context);
                  },
                ),
                _FilterOptionTile(
                  label: 'Lower Court',
                  selected: selectedCourtLevel == 'lower',
                  onTap: () {
                    onCourtLevelChanged('lower');
                    Navigator.pop(context);
                  },
                ),
                _FilterOptionTile(
                  label: 'High Court',
                  selected: selectedCourtLevel == 'high',
                  onTap: () {
                    onCourtLevelChanged('high');
                    Navigator.pop(context);
                  },
                ),
                _FilterOptionTile(
                  label: 'Supreme Court',
                  selected: selectedCourtLevel == 'supreme',
                  onTap: () {
                    onCourtLevelChanged('supreme');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showExperienceMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FilterOptionTile(
                  label: 'Any Experience',
                  selected: minimumExperience == null,
                  onTap: () {
                    onExperienceChanged(null);
                    Navigator.pop(context);
                  },
                ),
                _FilterOptionTile(
                  label: '3+ Years',
                  selected: minimumExperience == 3,
                  onTap: () {
                    onExperienceChanged(3);
                    Navigator.pop(context);
                  },
                ),
                _FilterOptionTile(
                  label: '5+ Years',
                  selected: minimumExperience == 5,
                  onTap: () {
                    onExperienceChanged(5);
                    Navigator.pop(context);
                  },
                ),
                _FilterOptionTile(
                  label: '10+ Years',
                  selected: minimumExperience == 10,
                  onTap: () {
                    onExperienceChanged(10);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DropdownFilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DropdownFilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: isSelected
          ? colorScheme.primary.withValues(alpha: 0.08)
          : colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterOptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterOptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: AppTextStyles.body.copyWith(
          color: colorScheme.onSurface,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      trailing: selected
          ? Icon(
              Icons.check_rounded,
              color: colorScheme.primary,
            )
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(child: CircularProgressIndicator(color: colorScheme.primary));
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Text(
          'Unable to load lawyers. Please try again.',
          textAlign: TextAlign.center,
          style: AppTextStyles.body.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: 58,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No lawyers available',
              style: AppTextStyles.title.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'There are currently no lawyers available '
              'in this category with the selected filters.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
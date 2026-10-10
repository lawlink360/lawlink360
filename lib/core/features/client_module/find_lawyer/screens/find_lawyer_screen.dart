import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/law_firm_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/law_firm_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_search_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_firms_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/category_lawyers_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/post_case_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/recently_viewed_lawyers_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/top_rated_law_firms_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/top_rated_lawyers_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/hero_section.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/law_firm_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/practice_area_card.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class FindLawyerScreen extends ConsumerStatefulWidget {
  const FindLawyerScreen({super.key});

  @override
  ConsumerState<FindLawyerScreen> createState() => _FindLawyerScreenState();
}

class _FindLawyerScreenState extends ConsumerState<FindLawyerScreen> {
  late final TextEditingController _searchController;
  Timer? _placeholderTimer;
  int _placeholderIndex = 0;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();

    _placeholderTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted || _searchController.text.isNotEmpty) return;

      setState(() {
        _placeholderIndex =
            (_placeholderIndex + 1) % LawyerSearchNotifier.practiceAreas.length;
      });
    });
  }

  @override
  void dispose() {
    _placeholderTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearch(String value) {
    ref.read(lawyerSearchProvider.notifier).setSearchQuery(value);

    setState(() {});
  }

  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryLawyersScreen(category: category),
      ),
    );
  }

  void _openTopRatedLawyers() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TopRatedLawyersScreen()),
    );
  }

  void _openTopRatedLawFirms() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TopRatedLawFirmsScreen()),
    );
  }

  void _openRecentlyViewed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RecentlyViewedLawyersScreen(),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // City filter sheet
  // ---------------------------------------------------------------------------

  /// User-facing label for the internal sentinel `'All'`.
  static const String _allCitiesLabel = 'All Cities';

  /// Maps the internal sentinel to the user-facing label.
  String _cityLabelFor(String internal) {
    if (internal.trim().isEmpty || internal == 'All') {
      return _allCitiesLabel;
    }
    return internal;
  }

  /// Maps a user-facing label back to the internal sentinel.
  String _internalForCityLabel(String label) {
    if (label == _allCitiesLabel) {
      return 'All';
    }
    return label;
  }

  void _showFilterSheet() {
    final searchState = ref.read(lawyerSearchProvider);

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final currentLabel = _cityLabelFor(searchState.selectedLocation);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter Lawyers',
                  style: AppTextStyles.title.copyWith(
                    color: Theme.of(sheetContext).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'City',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                DropdownButtonFormField<String>(
                  initialValue: currentLabel,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select city',
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: _allCitiesLabel,
                      child: Text(_allCitiesLabel),
                    ),
                    ...LawyerSearchNotifier.cities.map(
                      (city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    ref
                        .read(lawyerSearchProvider.notifier)
                        .setLocation(_internalForCityLabel(value));

                    Navigator.pop(sheetContext);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(lawyerSearchProvider.notifier).clearFilters();

                      _searchController.clear();
                      setState(() {});

                      Navigator.pop(sheetContext);
                    },
                    child: const Text('Clear Filters'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Ranking helpers
  // ---------------------------------------------------------------------------

  /// Top Rated Lawyers: rating desc → experience desc → name asc.
  /// Promotion status is intentionally NOT considered.
  List<Lawyer> _rankTopRatedLawyers(List<Lawyer> lawyers) {
    final sorted = List<Lawyer>.from(lawyers)
      ..sort((a, b) {
        final ratingCompare = b.rating.compareTo(a.rating);
        if (ratingCompare != 0) return ratingCompare;

        final experienceCompare = b.experience.compareTo(a.experience);
        if (experienceCompare != 0) return experienceCompare;

        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

    return sorted;
  }

  /// Top Rated Law Firms: rating desc → lawyersCount desc → name asc.
  /// Promotion status is intentionally NOT considered.
  List<LawFirm> _rankTopRatedFirms(List<LawFirm> firms) {
    final sorted = List<LawFirm>.from(firms)
      ..sort((a, b) {
        final ratingCompare = b.rating.compareTo(a.rating);
        if (ratingCompare != 0) return ratingCompare;

        final countCompare = b.lawyersCount.compareTo(a.lawyersCount);
        if (countCompare != 0) return countCompare;

        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

    return sorted;
  }

  /// Applies only the city filter to a list of lawyers.
  /// Used to build "discovery" portions (categories, top rated).
  List<Lawyer> _applyCityOnly(List<Lawyer> lawyers) {
    final selected = ref.read(lawyerSearchProvider).selectedLocation;

    if (selected.trim().isEmpty || selected == 'All') {
      return List<Lawyer>.from(lawyers);
    }

    final target = selected.trim().toLowerCase();

    return lawyers
        .where((lawyer) => lawyer.location.trim().toLowerCase() == target)
        .toList();
  }

  /// Applies only the city filter to a list of firms.
  List<LawFirm> _applyCityOnlyFirms(List<LawFirm> firms) {
    final selected = ref.read(lawyerSearchProvider).selectedLocation;

    if (selected.trim().isEmpty || selected == 'All') {
      return List<LawFirm>.from(firms);
    }

    final target = selected.trim().toLowerCase();

    return firms
        .where((firm) => firm.location.trim().toLowerCase() == target)
        .toList();
  }

  /// True when a city is selected AND no lawyers exist in that city.
  bool _isCityEmpty(List<Lawyer> allLawyers) {
    final selected = ref.read(lawyerSearchProvider).selectedLocation;

    if (selected.trim().isEmpty || selected == 'All') {
      return false;
    }

    return _applyCityOnly(allLawyers).isEmpty;
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final directoryAsync = ref.watch(lawyerDirectoryProvider);
    final firmAsync = ref.watch(lawFirmDirectoryProvider);
    final recentlyViewed = ref.watch(recentlyViewedProvider);
    final recentlyViewedFirms = ref.watch(recentlyViewedFirmsProvider);
    final searchState = ref.watch(lawyerSearchProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Find Lawyer',
          style: AppTextStyles.title.copyWith(color: colorScheme.onSurface),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorScheme.onSurface,
          ),
          tooltip: 'Back',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: directoryAsync.when(
          loading: () => const _LoadingView(),
          error: (error, stackTrace) => _ErrorView(
            onRetry: () {
              ref.invalidate(lawyerDirectoryProvider);
            },
          ),
          data: (lawyers) {
            final showSearchResults =
                searchState.searchQuery.trim().isNotEmpty;

            // Full filter pipeline (search + all filters incl. city).
            final filteredLawyers = ref
                .read(lawyerSearchProvider.notifier)
                .filterLawyers(lawyers);

            // City-only slice used for "discovery" portions.
            final cityLawyers = _applyCityOnly(lawyers);

            // Whether the selected city itself has no lawyers at all.
            final cityIsEmpty = _isCityEmpty(lawyers);

            final selectedCityLabel = _cityLabelFor(
              searchState.selectedLocation,
            );

            final legalCategories = _buildLegalCategories(cityLawyers);

            final topRated = _rankTopRatedLawyers(cityLawyers);

            final matchingCategory = ref
                .read(lawyerSearchProvider.notifier)
                .findMatchingPracticeArea(searchState.searchQuery);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeroSection(),

                  const SizedBox(height: AppSpacing.lg),

                  // Search + circular city filter button.
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _SearchField(
                            colorScheme: colorScheme,
                            controller: _searchController,
                            hintText:
                                'Search ${LawyerSearchNotifier.practiceAreas[_placeholderIndex]}',
                            onChanged: _updateSearch,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _CircularFilterButton(
                          colorScheme: colorScheme,
                          hasActiveFilter:
                              searchState.selectedLocation != 'All',
                          onPressed: _showFilterSheet,
                        ),
                      ],
                    ),
                  ),

                  if (showSearchResults) ...[
                    const SizedBox(height: AppSpacing.md),

                    if (matchingCategory != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: _CategorySearchResult(
                          category: matchingCategory,
                          onTap: () => _openCategory(matchingCategory),
                        ),
                      ),

                    const SizedBox(height: AppSpacing.md),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: _SearchResultsHeader(
                        query: searchState.searchQuery,
                        resultCount: filteredLawyers.length,
                      ),
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    if (filteredLawyers.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: _InlineEmptyMessage(
                          message: cityIsEmpty
                              ? 'No lawyers are currently available in '
                                    '$selectedCityLabel.\n'
                                    "We're working to onboard lawyers in your "
                                    'city soon.'
                              : 'No lawyers found for your search. '
                                    'Try another name or legal category.',
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          children: filteredLawyers
                              .take(5)
                              .map(
                                (lawyer) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.sm,
                                  ),
                                  child: LawyerCard(lawyer: lawyer),
                                ),
                              )
                              .toList(),
                        ),
                      ),

                    const SizedBox(height: AppSpacing.sm),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          ref
                              .read(lawyerSearchProvider.notifier)
                              .clearFilters();

                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear_rounded),
                        label: const Text('Clear Search'),
                      ),
                    ),
                  ],

                  const SizedBox(height: AppSpacing.xxl),

                  // Legal Categories
                  _SectionTitle(
                    title: 'Legal Categories',
                    color: colorScheme.onSurface,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: legalCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisSpacing: AppSpacing.md,
                            childAspectRatio: 1.05,
                          ),
                      itemBuilder: (context, index) {
                        final category = legalCategories[index];

                        final isSelected =
                            searchState.selectedPracticeArea == category.title;

                        return PracticeAreaCard(
                          icon: category.icon,
                          title: category.title,
                          lawyers:
                              '${category.count} ${category.count == 1 ? 'Lawyer' : 'Lawyers'}',
                          selected: isSelected,
                          onTap: () => _openCategory(category.title),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Post Your Case — intentionally independent of city.
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: _PostCaseCard(colorScheme: colorScheme),
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Top Rated Lawyers
                  _SectionTitle(
                    title: 'Top Rated Lawyers',
                    color: colorScheme.onSurface,
                    trailing: _ViewAllButton(
                      onPressed: _openTopRatedLawyers,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  if (cityIsEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: _InlineEmptyMessage(
                        message:
                            'No lawyers are currently available in '
                            '$selectedCityLabel.\n'
                            "We're working to onboard lawyers in your city "
                            'soon.',
                      ),
                    )
                  else if (topRated.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: _InlineEmptyMessage(
                        message: 'No lawyers are currently available.',
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: topRated
                            .take(5)
                            .map((lawyer) => LawyerCard(lawyer: lawyer))
                            .toList(),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Top Rated Law Firms
                  firmAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    data: (firms) {
                      final cityFirms = _applyCityOnlyFirms(firms);
                      final topRatedFirms = _rankTopRatedFirms(cityFirms);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionTitle(
                            title: 'Top Rated Law Firms',
                            color: colorScheme.onSurface,
                            trailing: _ViewAllButton(
                              onPressed: _openTopRatedLawFirms,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          if (topRatedFirms.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                              ),
                              child: _InlineEmptyMessage(
                                message:
                                    'No law firms are currently available.',
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                              ),
                              child: Column(
                                children: topRatedFirms
                                    .take(4)
                                    .map(
                                      (firm) => LawFirmCard(firm: firm),
                                    )
                                    .toList(),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Recently Viewed Lawyers — always visible, city-independent.
                  // Home preview shows a maximum of 3 (newest first).
                  // The full retained history is available via View All,
                  // which opens the combined Recently Viewed screen.
                  _SectionTitle(
                    title: 'Recently Viewed Lawyers',
                    color: colorScheme.onSurface,
                    trailing: _ViewAllButton(
                      onPressed: _openRecentlyViewed,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  if (recentlyViewed.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: _RecentlyViewedEmptyState(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: recentlyViewed
                            .take(3)
                            .map((lawyer) => LawyerCard(lawyer: lawyer))
                            .toList(),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Recently Viewed Law Firms — always visible, city-independent.
                  // Home preview shows a maximum of 3 (newest first).
                  // View All opens the same combined Recently Viewed screen.
                  _SectionTitle(
                    title: 'Recently Viewed Law Firms',
                    color: colorScheme.onSurface,
                    trailing: _ViewAllButton(
                      onPressed: _openRecentlyViewed,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  if (recentlyViewedFirms.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: _RecentlyViewedFirmsEmptyState(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: recentlyViewedFirms
                            .take(3)
                            .map((firm) => LawFirmCard(firm: firm))
                            .toList(),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<_LegalCategoryData> _buildLegalCategories(List<Lawyer> lawyers) {
    const definitions = <_LegalCategoryDefinition>[
      _LegalCategoryDefinition(
        title: 'Civil Law',
        icon: Icons.description_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Criminal Law',
        icon: Icons.gavel_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Family & Guardian',
        icon: Icons.family_restroom_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Corporate & Commercial Law',
        icon: Icons.business_center_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Company & Firm Registration',
        icon: Icons.app_registration_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Tax & FBR',
        icon: Icons.receipt_long_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Labour & Employment',
        icon: Icons.work_outline_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Immigration Law',
        icon: Icons.flight_takeoff_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Banking & Finance',
        icon: Icons.account_balance_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Constitutional Law',
        icon: Icons.account_balance_wallet_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Narcotics',
        icon: Icons.warning_amber_rounded,
      ),
      _LegalCategoryDefinition(title: 'NAB & FIA', icon: Icons.policy_rounded),
      _LegalCategoryDefinition(
        title: 'Consumer Protection',
        icon: Icons.shopping_bag_outlined,
      ),
      _LegalCategoryDefinition(
        title: 'Cyber Crime & Harassment',
        icon: Icons.security_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Medical & Drugs',
        icon: Icons.medical_services_outlined,
      ),
      _LegalCategoryDefinition(
        title: 'BOR / Revenue',
        icon: Icons.landscape_outlined,
      ),
      _LegalCategoryDefinition(
        title: 'Environmental Law',
        icon: Icons.eco_outlined,
      ),
      _LegalCategoryDefinition(
        title: 'Intellectual Property',
        icon: Icons.lightbulb_outline_rounded,
      ),
      _LegalCategoryDefinition(
        title: 'Alternative Dispute Resolution (ADR)',
        icon: Icons.handshake_outlined,
      ),
    ];

    return definitions.map((definition) {
      final count = ref
          .read(lawyerSearchProvider.notifier)
          .countForPracticeArea(lawyers, definition.title);

      return _LegalCategoryData(
        title: definition.title,
        count: count,
        icon: definition.icon,
      );
    }).toList();
  }
}

// -----------------------------------------------------------------------------
// Small local widgets
// -----------------------------------------------------------------------------

class _LegalCategoryDefinition {
  final String title;
  final IconData icon;

  const _LegalCategoryDefinition({required this.title, required this.icon});
}

class _LegalCategoryData {
  final String title;
  final int count;
  final IconData icon;

  const _LegalCategoryData({
    required this.title,
    required this.count,
    required this.icon,
  });
}

class _SearchField extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.colorScheme,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Icon(Icons.search_rounded, color: colorScheme.primary),
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

/// Circular filter button beside the search field.
class _CircularFilterButton extends StatelessWidget {
  final ColorScheme colorScheme;
  final bool hasActiveFilter;
  final VoidCallback onPressed;

  const _CircularFilterButton({
    required this.colorScheme,
    required this.hasActiveFilter,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final background = hasActiveFilter
        ? colorScheme.primary.withValues(alpha: 0.10)
        : colorScheme.surfaceContainerHighest.withValues(alpha: 0.55);

    final iconColor = hasActiveFilter
        ? colorScheme.primary
        : colorScheme.onSurface;

    final borderColor = hasActiveFilter
        ? colorScheme.primary
        : colorScheme.outline.withValues(alpha: 0.25);

    return Material(
      color: background,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
          ),
          child: Icon(
            Icons.tune_rounded,
            color: iconColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _CategorySearchResult extends StatelessWidget {
  final String category;
  final VoidCallback onTap;

  const _CategorySearchResult({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  Icons.category_outlined,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Legal category found',
                      style: AppTextStyles.caption.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      category,
                      style: AppTextStyles.body.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchResultsHeader extends StatelessWidget {
  final String query;
  final int resultCount;

  const _SearchResultsHeader({required this.query, required this.resultCount});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      '$resultCount ${resultCount == 1 ? 'lawyer' : 'lawyers'} found for "$query"',
      style: AppTextStyles.caption.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  final Widget? trailing;

  const _SectionTitle({
    required this.title,
    required this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.headline.copyWith(
                color: color,
                fontSize: 23,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _ViewAllButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ViewAllButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        'View All',
        style: AppTextStyles.caption.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PostCaseCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _PostCaseCard({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Theme.of(context).brightness == Brightness.dark
                  ? 0.25
                  : 0.10,
            ),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.support_agent_rounded,
            color: AppColors.accent,
            size: 30,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "Can't Find the Right Lawyer?",
            style: AppTextStyles.title.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Post your legal case and receive proposals from verified lawyers across Pakistan.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PostCaseScreen()),
                );
              },
              icon: const Icon(Icons.gavel_rounded, size: 20),
              label: Text(
                'Post Your Case',
                style: AppTextStyles.button.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentlyViewedEmptyState extends StatelessWidget {
  const _RecentlyViewedEmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.history_rounded,
            color: colorScheme.onSurfaceVariant,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'Lawyers you view will appear here for quick access.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentlyViewedFirmsEmptyState extends StatelessWidget {
  const _RecentlyViewedFirmsEmptyState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.business_outlined,
            color: colorScheme.onSurfaceVariant,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'Law firms you view will appear here for quick access.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: colorScheme.primary),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Loading verified lawyers...',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 46,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Unable to load lawyers',
              style: AppTextStyles.title.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Please check your connection and try again.',
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(onPressed: onRetry, child: const Text('Try Again')),
          ],
        ),
      ),
    );
  }
}

class _InlineEmptyMessage extends StatelessWidget {
  final String message;

  const _InlineEmptyMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(
        message,
        style: AppTextStyles.bodySmall.copyWith(
          color: colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
      ),
    );
  }
}
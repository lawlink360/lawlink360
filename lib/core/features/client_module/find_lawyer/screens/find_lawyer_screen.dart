import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/law_firm_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/law_firm_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_search_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/category_lawyers_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/hero_section.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/practice_area_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/law_firm_profile_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/chat_screen.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/book_appointment_screen.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/screens/post_case_screen.dart';

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

  void _showFilterSheet() {
    final searchState = ref.read(lawyerSearchProvider);
    final lawyers = ref.read(lawyerDirectoryProvider).valueOrNull ?? [];

    final locations = <String>{
      ...lawyers
          .map((lawyer) => lawyer.location.trim())
          .where((location) => location.isNotEmpty),
    }.toList()..sort();

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
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
                  'Location',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                DropdownButtonFormField<String>(
                  initialValue: searchState.selectedLocation,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select location',
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: 'All',
                      child: Text('All Locations'),
                    ),
                    ...locations.map(
                      (location) => DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    ref.read(lawyerSearchProvider.notifier).setLocation(value);

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final directoryAsync = ref.watch(lawyerDirectoryProvider);
    final firmAsync = ref.watch(lawFirmDirectoryProvider);
    final recentlyViewed = ref.watch(recentlyViewedProvider);
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
            final filteredLawyers = ref
                .read(lawyerSearchProvider.notifier)
                .filterLawyers(lawyers);

            final topRated = [...lawyers]
              ..sort((a, b) {
                if (a.hasActivePromotion != b.hasActivePromotion) {
                  return a.hasActivePromotion ? -1 : 1;
                }

                if (a.hasActivePromotion &&
                    b.hasActivePromotion &&
                    a.promotionPriority != b.promotionPriority) {
                  return b.promotionPriority.compareTo(a.promotionPriority);
                }

                return b.rating.compareTo(a.rating);
              });

            final legalCategories = _buildLegalCategories(lawyers);

            final matchingCategory = ref
                .read(lawyerSearchProvider.notifier)
                .findMatchingPracticeArea(searchState.searchQuery);

            final showSearchResults = searchState.searchQuery.trim().isNotEmpty;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeroSection(),

                  const SizedBox(height: AppSpacing.lg),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: _SearchField(
                      colorScheme: colorScheme,
                      controller: _searchController,
                      hintText:
                          'Search ${LawyerSearchNotifier.practiceAreas[_placeholderIndex]}',
                      onChanged: _updateSearch,
                      onFilterPressed: _showFilterSheet,
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
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: _InlineEmptyMessage(
                          message:
                              'No lawyers found for your search. Try another name or legal category.',
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

                  _SectionTitle(
                    title: 'Top Rated Lawyers',
                    color: colorScheme.onSurface,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  if (topRated.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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

                  firmAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    data: (firms) {
                      final topRatedFirms = [...firms]
                        ..sort((a, b) {
                          if (a.hasActivePromotion != b.hasActivePromotion) {
                            return a.hasActivePromotion ? -1 : 1;
                          }

                          if (a.hasActivePromotion &&
                              b.hasActivePromotion &&
                              a.promotionPriority != b.promotionPriority) {
                            return b.promotionPriority.compareTo(
                              a.promotionPriority,
                            );
                          }

                          return b.rating.compareTo(a.rating);
                        });

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionTitle(
                            title: 'Top Rated Law Firms',
                            color: colorScheme.onSurface,
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
                                    .map((firm) => _LawFirmCard(firm: firm))
                                    .toList(),
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  _SectionTitle(
                    title: 'Recently Viewed Lawyers',
                    color: colorScheme.onSurface,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  if (recentlyViewed.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      child: _RecentlyViewedEmptyState(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: recentlyViewed
                            .map((lawyer) => LawyerCard(lawyer: lawyer))
                            .toList(),
                      ),
                    ),

                  const SizedBox(height: AppSpacing.xxl),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: _PostCaseCard(colorScheme: colorScheme),
                  ),
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
  final VoidCallback onFilterPressed;

  const _SearchField({
    required this.colorScheme,
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onFilterPressed,
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
        suffixIcon: IconButton(
          onPressed: onFilterPressed,
          icon: Icon(Icons.tune_rounded, color: colorScheme.primary),
          tooltip: 'Filter lawyers',
        ),
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

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Text(
        title,
        style: AppTextStyles.headline.copyWith(color: color, fontSize: 23),
      ),
    );
  }
}

class _LawFirmCard extends ConsumerStatefulWidget {
  final LawFirm firm;

  const _LawFirmCard({required this.firm});

  @override
  ConsumerState<_LawFirmCard> createState() => _LawFirmCardState();
}

class _LawFirmCardState extends ConsumerState<_LawFirmCard> {
  bool _isFavorite = false;

  Future<void> _shareFirm() async {
    final firm = widget.firm;

    final specialization = firm.specializationSummary.isNotEmpty
        ? firm.specializationSummary
        : firm.description;

    await Share.share(
      '${firm.name}\n'
      '${firm.location}\n\n'
      '$specialization\n\n'
      'Consultation fee: PKR ${firm.consultationFee.toStringAsFixed(0)}\n'
      'Lawyers: ${firm.lawyersCount}\n'
      'Rating: ${firm.rating.toStringAsFixed(1)}',
    );
  }

  void _openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChatScreen()),
    );
  }

  void _openFirmProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LawFirmProfileScreen(firm: widget.firm),
      ),
    );
  }

  void _bookAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BookAppointmentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firm = widget.firm;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final specialization = firm.specializationSummary.isNotEmpty
        ? firm.specializationSummary
        : firm.description;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: firm.hasActivePromotion
              ? AppColors.accent.withValues(alpha: 0.55)
              : colorScheme.outline.withValues(alpha: 0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.20 : 0.06),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(
                  Icons.business_rounded,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            firm.name,
                            style: AppTextStyles.title.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 17,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (firm.verified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColors.success,
                            size: 20,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            firm.location,
                            style: AppTextStyles.caption.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    tooltip: _isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      _isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: _isFavorite
                          ? Colors.red
                          : colorScheme.onSurfaceVariant,
                      size: 21,
                    ),
                  ),
                  IconButton(
                    onPressed: _shareFirm,
                    tooltip: 'Share firm',
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.share_rounded,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (firm.hasActivePromotion) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: AppColors.accent,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Featured',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.md),

          Text(
            specialization,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: firm.practiceAreas.take(3).map((area) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.65,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  area,
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: AppSpacing.md),

          Divider(
            color: colorScheme.outline.withValues(alpha: 0.45),
            height: 1,
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              const Icon(Icons.star_rounded, color: AppColors.accent, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Text(
                firm.rating.toStringAsFixed(1),
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(
                Icons.people_alt_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  '${firm.lawyersCount} Lawyers',
                  style: AppTextStyles.caption.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          Row(
            children: [
              Icon(
                Icons.payments_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'PKR ${firm.consultationFee.toStringAsFixed(0)} consultation',
                style: AppTextStyles.caption.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Icon(
                firm.isOnline ? Icons.circle : Icons.schedule_rounded,
                color: firm.isOnline
                    ? AppColors.success
                    : colorScheme.onSurfaceVariant,
                size: firm.isOnline ? 10 : 17,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                firm.isOnline ? 'Available online' : 'Currently unavailable',
                style: AppTextStyles.caption.copyWith(
                  color: firm.isOnline
                      ? AppColors.success
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _openFirmProfile,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    side: BorderSide(
                      color: colorScheme.primary.withValues(alpha: 0.45),
                    ),
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: const Text('View Firm'),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _openChat,
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                  label: const Text('Chat'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    side: BorderSide(
                      color: colorScheme.primary.withValues(alpha: 0.45),
                    ),
                    minimumSize: const Size.fromHeight(44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          SizedBox(
            width: double.infinity,
            height: AppSpacing.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: _bookAppointment,
              icon: const Icon(Icons.calendar_month_rounded),
              label: const Text('Book Appointment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
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
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.30),
        ),
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
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
              ),
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
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
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
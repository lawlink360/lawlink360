import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/law_firm_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/law_firm_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_search_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/law_firm_card.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Full list of law firms ranked by:
/// Rating desc → Lawyers count desc → Name asc.
///
/// Respects the currently selected city from [lawyerSearchProvider].
/// The city selection is preserved when navigating into this screen.
class TopRatedLawFirmsScreen extends ConsumerWidget {
  const TopRatedLawFirmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final directoryAsync = ref.watch(lawFirmDirectoryProvider);
    final selectedCity = ref.watch(
      lawyerSearchProvider.select((state) => state.selectedLocation),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Top Rated Law Firms',
          style: AppTextStyles.title.copyWith(color: colorScheme.onSurface),
        ),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
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
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.xxl),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Text(
                'Unable to load law firms. Please try again.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          data: (allFirms) {
            final cityFiltered = _filterByCity(allFirms, selectedCity);
            final ranked = _rankByRating(cityFiltered);

            final cityLabel = (selectedCity.trim().isEmpty ||
                    selectedCity == 'All')
                ? 'All Cities'
                : selectedCity;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    0,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            cityLabel,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${ranked.length} '
                          '${ranked.length == 1 ? 'firm' : 'firms'}',
                          style: AppTextStyles.caption.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: ranked.isEmpty
                      ? _EmptyCityState(cityLabel: cityLabel)
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            AppSpacing.xs,
                            AppSpacing.lg,
                            AppSpacing.xxl,
                          ),
                          itemCount: ranked.length,
                          itemBuilder: (context, index) {
                            return LawFirmCard(firm: ranked[index]);
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static List<LawFirm> _filterByCity(
    List<LawFirm> firms,
    String selectedCity,
  ) {
    if (selectedCity.trim().isEmpty || selectedCity == 'All') {
      return List<LawFirm>.from(firms);
    }

    final target = selectedCity.trim().toLowerCase();

    return firms
        .where((firm) => firm.location.trim().toLowerCase() == target)
        .toList();
  }

  static List<LawFirm> _rankByRating(List<LawFirm> firms) {
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
}

class _EmptyCityState extends StatelessWidget {
  final String cityLabel;

  const _EmptyCityState({required this.cityLabel});

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
              Icons.business_outlined,
              size: 58,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No law firms are currently available in $cityLabel.',
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "We're working to onboard law firms in your city soon.",
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
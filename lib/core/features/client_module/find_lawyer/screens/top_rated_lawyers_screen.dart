import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/lawyer_search_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_card.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Full list of lawyers ranked by:
/// Rating desc → Experience desc → Name asc.
///
/// Respects the currently selected city from [lawyerSearchProvider].
/// The city selection is preserved when navigating into this screen.
class TopRatedLawyersScreen extends ConsumerWidget {
  const TopRatedLawyersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final directoryAsync = ref.watch(lawyerDirectoryProvider);
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
          'Top Rated Lawyers',
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
                'Unable to load lawyers. Please try again.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          data: (allLawyers) {
            final cityFiltered = _filterByCity(allLawyers, selectedCity);
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
                          '${ranked.length == 1 ? 'lawyer' : 'lawyers'}',
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
                            return LawyerCard(lawyer: ranked[index]);
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

  static List<Lawyer> _filterByCity(List<Lawyer> lawyers, String selectedCity) {
    if (selectedCity.trim().isEmpty || selectedCity == 'All') {
      return List<Lawyer>.from(lawyers);
    }

    final target = selectedCity.trim().toLowerCase();

    return lawyers
        .where((lawyer) => lawyer.location.trim().toLowerCase() == target)
        .toList();
  }

  static List<Lawyer> _rankByRating(List<Lawyer> lawyers) {
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
              Icons.people_outline_rounded,
              size: 58,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No lawyers are currently available in $cityLabel.',
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "We're working to onboard lawyers in your city soon.",
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../providers/lawyer_provider.dart';
import '../providers/lawyer_search_provider.dart';
import '../widgets/lawyer_card.dart';
import '../models/lawyer_model.dart';

class CategoryLawyersScreen extends ConsumerStatefulWidget {
  final String category;

  const CategoryLawyersScreen({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<CategoryLawyersScreen> createState() =>
      _CategoryLawyersScreenState();
}

class _CategoryLawyersScreenState
    extends ConsumerState<CategoryLawyersScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Lawyer> _filterCategoryLawyers(
    List<Lawyer> lawyers,
    String query,
  ) {
    final normalizedQuery = query.trim().toLowerCase();

    return lawyers.where((lawyer) {
      final matchesCategory = ref
          .read(lawyerSearchProvider.notifier)
          .matchesPracticeAreaForLawyer(
            lawyer,
            widget.category,
          );

      if (!matchesCategory) {
        return false;
      }

      if (normalizedQuery.isEmpty) {
        return true;
      }

      final name = lawyer.name.trim().toLowerCase();
      final speciality = lawyer.speciality.trim().toLowerCase();
      final location = lawyer.location.trim().toLowerCase();

      return name.contains(normalizedQuery) ||
          speciality.contains(normalizedQuery) ||
          location.contains(normalizedQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final directoryAsync = ref.watch(lawyerDirectoryProvider);

    return Scaffold(
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
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: directoryAsync.when(
          loading: () => const _LoadingView(),
          error: (error, stackTrace) => const _ErrorView(),
          data: (lawyers) {
            final categoryLawyers = _filterCategoryLawyers(
              lawyers,
              _searchController.text,
            );

            final sortedLawyers = [...categoryLawyers]
              ..sort(
                (a, b) => b.rating.compareTo(a.rating),
              );

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.sm,
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
                      TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText:
                              'Search ${widget.category} lawyers',
                          hintStyle: AppTextStyles.bodySmall.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: colorScheme.primary,
                          ),
                          filled: true,
                          fillColor:
                              colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.55),
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.md,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppRadius.xl,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppRadius.xl,
                            ),
                            borderSide: BorderSide(
                              color: colorScheme.outline
                                  .withValues(alpha: 0.25),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppRadius.xl,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.accent,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
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
                            return LawyerCard(
                              lawyer: sortedLawyers[index],
                            );
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
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: CircularProgressIndicator(
        color: colorScheme.primary,
      ),
    );
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
              style: AppTextStyles.title.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'There are currently no lawyers available in '
              '${'this category'}.',
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
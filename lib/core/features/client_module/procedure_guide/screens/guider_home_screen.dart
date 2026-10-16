import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/procedure_data.dart';
import '../providers/procedure_providers.dart';
import '../widgets/guider_header.dart';
import '../widgets/guider_search_bar.dart';
import '../widgets/procedure_card.dart';
import '../widgets/procedure_category_card.dart';
import '../widgets/procedure_statistics_cards.dart';
import '../widgets/recently_viewed_procedures.dart';
import 'procedure_category_screen.dart';
import 'procedure_detail_screen.dart';

class GuiderHomeScreen extends ConsumerStatefulWidget {
  const GuiderHomeScreen({super.key});

  @override
  ConsumerState<GuiderHomeScreen> createState() => _GuiderHomeScreenState();
}

class _GuiderHomeScreenState extends ConsumerState<GuiderHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    ref.read(procedureSearchProvider.notifier).updateQuery(value);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ProcedureData.categories;
    final query = ref.watch(procedureSearchProvider).trim();
    final isSearching = query.isNotEmpty;
    final filtered = ref.watch(filteredProceduresProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Procedure Guider',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          bottom: AppSpacing.xl,
        ),
        children: [
          const GuiderHeader(),
          const ProcedureStatisticsCards(),
          GuiderSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            child: isSearching
                ? _buildSearchResults(filtered)
                : _buildCategories(categories),
          ),
          if (!isSearching) const RecentlyViewedProcedures(),
          const _FindLawyerPromoSection(),
        ],
      ),
    );
  }

  Widget _buildCategories(List<dynamic> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final procedureCount = ProcedureData.procedures
            .where((p) => p.categoryId == category.id)
            .length;

        return ProcedureCategoryCard(
          icon: category.icon,
          color: category.color,
          title: category.title,
          procedureCount: procedureCount,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProcedureCategoryScreen(
                  categoryId: category.id,
                  title: category.title,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchResults(List<dynamic> results) {
    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
        ),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'No procedures matched your search.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: results.map((procedure) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: AppSpacing.sm,
          ),
          child: ProcedureCard(
            title: procedure.title,
            overview: procedure.overview,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProcedureDetailScreen(
                    procedure: procedure,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}

class _FindLawyerPromoSection extends StatelessWidget {
  const _FindLawyerPromoSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.18),
              blurRadius: 16,
              offset: const Offset(0, 6),
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
              'Need Legal Assistance?',
              style: AppTextStyles.title.copyWith(
                color: AppColors.textLight,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Connect with experienced lawyers through LawLink360.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textLight.withValues(alpha: 0.82),
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: AppSpacing.buttonHeight,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/find-lawyer');
                },
                icon: const Icon(Icons.gavel_rounded, size: 20),
                label: Text(
                  'Find a Lawyer',
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
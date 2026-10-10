import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/procedure_data.dart';
import '../providers/procedure_providers.dart';
import '../widgets/guider_header.dart';
import '../widgets/guider_search_bar.dart';
import '../widgets/procedure_card.dart';
import '../widgets/procedure_category_card.dart';
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
        ],
      ),
    );
  }

  Widget _buildCategories(List<dynamic> categories) {
    return Column(
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: AppSpacing.sm,
          ),
          child: ProcedureCategoryCard(
            icon: category.icon,
            color: category.color,
            title: category.title,
            description: category.description,
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
          ),
        );
      }).toList(),
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
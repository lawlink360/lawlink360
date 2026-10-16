import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/procedure_data.dart';
import '../models/procedure_category.dart';
import '../widgets/procedure_card.dart';
import 'procedure_detail_screen.dart';

class ProcedureCategoryScreen extends StatelessWidget {
  final String categoryId;
  final String title;

  const ProcedureCategoryScreen({
    super.key,
    required this.categoryId,
    required this.title,
  });

  ProcedureCategory? get _category {
    for (final category in ProcedureData.categories) {
      if (category.id == categoryId) return category;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final category = _category;
    final procedures = ProcedureData.procedures
        .where((p) => p.categoryId == categoryId)
        .toList();

    if (category == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            title,
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
        body: _buildProcedureList(context, procedures),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _ProcedureCategoryHeader(
              category: category,
              count: procedures.length,
            ),
            Expanded(
              child: _buildProcedureList(context, procedures),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcedureList(
    BuildContext context,
    List<dynamic> procedures,
  ) {
    if (procedures.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.description_outlined,
                size: 48,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'No procedures are available in this category yet.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: procedures.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final procedure = procedures[index];

        return ProcedureCard(
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
        );
      },
    );
  }
}

class _ProcedureCategoryHeader extends StatelessWidget {
  final ProcedureCategory category;
  final int count;

  const _ProcedureCategoryHeader({
    required this.category,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.xl),
          bottomRight: Radius.circular(AppRadius.xl),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/logos/lawlink360_transparent_logo.png',
                  height: 40,
                ),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(AppSpacing.xs),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textLight,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.textLight.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.textLight,
                    size: 29,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headline.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '$count ${count == 1 ? 'Procedure' : 'Procedures'}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textLight.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Container(
                        height: 1,
                        color: AppColors.textLight.withValues(alpha: 0.18),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        category.description,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textLight.withValues(alpha: 0.72),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
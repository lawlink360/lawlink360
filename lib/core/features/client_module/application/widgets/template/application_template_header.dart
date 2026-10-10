import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../../models/document_category.dart';
import '../../models/document_subcategory.dart';

class ApplicationTemplateHeader extends StatelessWidget {
  final DocumentCategory category;
  final DocumentSubCategory? subCategory;
  final int count;
  final String countLabel;

  const ApplicationTemplateHeader({
    super.key,
    required this.category,
    this.subCategory,
    required this.count,
    required this.countLabel,
  });

  bool get _isSubCategoryView => subCategory != null;

  String get _mainTitle =>
      _isSubCategoryView ? subCategory!.title : category.title;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            AppColors.secondary,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppRadius.xl),
          bottomRight: Radius.circular(AppRadius.xl),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
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

            if (_isSubCategoryView) ...[
              _BreadcrumbRow(
                categoryTitle: category.title,
                subCategoryTitle: subCategory!.title,
              ),
              const SizedBox(height: AppSpacing.sm),
            ],

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
                    _isSubCategoryView
                        ? subCategory!.icon
                        : category.icon,
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
                        _mainTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headline.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.xs),

                      Text(
                        '$count $countLabel',
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
                        _isSubCategoryView
                            ? subCategory!.description
                            : category.description,
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

class _BreadcrumbRow extends StatelessWidget {
  final String categoryTitle;
  final String subCategoryTitle;

  const _BreadcrumbRow({
    required this.categoryTitle,
    required this.subCategoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final breadcrumbStyle = AppTextStyles.caption.copyWith(
      color: AppColors.textLight.withValues(alpha: 0.72),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );

    final currentStyle = AppTextStyles.caption.copyWith(
      color: AppColors.textLight,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    );

    return Row(
      children: [
        Flexible(
          child: Text(
            categoryTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: breadcrumbStyle,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
          ),
          child: Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: AppColors.textLight.withValues(alpha: 0.55),
          ),
        ),

        Flexible(
          child: Text(
            subCategoryTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: currentStyle,
          ),
        ),
      ],
    );
  }
}
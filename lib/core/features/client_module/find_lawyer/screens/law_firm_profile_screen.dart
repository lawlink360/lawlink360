import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/law_firm_model.dart';
import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class LawFirmProfileScreen extends StatelessWidget {
  final LawFirm firm;

  const LawFirmProfileScreen({
    super.key,
    required this.firm,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Law Firm Profile',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
          ),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  border: Border.all(
                    color: firm.hasActivePromotion
                        ? AppColors.accent.withValues(alpha: 0.55)
                        : colorScheme.outline.withValues(alpha: 0.35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: Theme.of(context).brightness == Brightness.dark
                            ? 0.20
                            : 0.06,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                      ),
                      child: Icon(
                        Icons.business_rounded,
                        color: colorScheme.primary,
                        size: 38,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            firm.name,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(
                              color: colorScheme.onSurface,
                              fontSize: 21,
                            ),
                          ),
                        ),
                        if (firm.verified) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColors.success,
                            size: 21,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Flexible(
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
                    if (firm.hasActivePromotion) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.12),
                          borderRadius:
                              BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.accent,
                              size: 17,
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
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'About the Firm',
                style: AppTextStyles.headline.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),

              Text(
                firm.description,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.55,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'Practice Areas',
                style: AppTextStyles.headline.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: firm.practiceAreas
                    .map(
                      (area) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.65),
                          borderRadius:
                              BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          area,
                          style: AppTextStyles.caption.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: AppSpacing.xl),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.30),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _FirmStat(
                        icon: Icons.star_rounded,
                        value: firm.rating.toStringAsFixed(1),
                        label: 'Rating',
                        iconColor: AppColors.accent,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 45,
                      color: colorScheme.outline.withValues(alpha: 0.25),
                    ),
                    Expanded(
                      child: _FirmStat(
                        icon: Icons.people_alt_rounded,
                        value: '${firm.lawyersCount}',
                        label: 'Lawyers',
                        iconColor: colorScheme.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 45,
                      color: colorScheme.outline.withValues(alpha: 0.25),
                    ),
                    Expanded(
                      child: _FirmStat(
                        icon: Icons.verified_rounded,
                        value: firm.verified ? 'Yes' : 'No',
                        label: 'Verified',
                        iconColor: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Firm lawyer-directory/booking functionality
                    // will be connected during the backend phase.
                  },
                  icon: const Icon(Icons.people_alt_rounded),
                  label: const Text('View Lawyers'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirmStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const _FirmStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTextStyles.body.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
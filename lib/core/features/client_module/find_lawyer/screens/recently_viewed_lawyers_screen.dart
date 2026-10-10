import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/client_module/find_lawyer/models/law_firm_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/models/lawyer_model.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_firms_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/providers/recently_viewed_provider.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/law_firm_card.dart';
import 'package:lawlink360/core/features/client_module/find_lawyer/widgets/lawyer_card.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

/// Combined Recently Viewed screen.
///
/// Shows two independent sections:
///   • Recently Viewed Lawyers  — from [recentlyViewedProvider]
///   • Recently Viewed Law Firms — from [recentlyViewedFirmsProvider]
///
/// Both sections are newest-first, retain up to 5 entries each, and support
/// per-item removal that only affects the history entry, never the source
/// record.
class RecentlyViewedLawyersScreen extends ConsumerWidget {
  const RecentlyViewedLawyersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final recentlyViewedLawyers = ref.watch(recentlyViewedProvider);
    final recentlyViewedFirms = ref.watch(recentlyViewedFirmsProvider);

    final bothEmpty =
        recentlyViewedLawyers.isEmpty && recentlyViewedFirms.isEmpty;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Recently Viewed',
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
        child: bothEmpty
            ? _BothEmptyState()
            : ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                children: [
                  // -----------------------------------------------------------
                  // Recently Viewed Lawyers
                  // -----------------------------------------------------------
                  _SectionHeader(
                    title: 'Recently Viewed Lawyers',
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  if (recentlyViewedLawyers.isEmpty)
                    _SectionEmptyState(
                      icon: Icons.person_outline_rounded,
                      message:
                          'No recently viewed lawyers yet. '
                          'Lawyers you view will appear here.',
                      colorScheme: colorScheme,
                    )
                  else
                    Column(
                      children: recentlyViewedLawyers.map((lawyer) {
                        return _RemovableLawyerRow(
                          key: ValueKey('lawyer_${lawyer.id}'),
                          lawyer: lawyer,
                          onRemove: () {
                            ref
                                .read(recentlyViewedProvider.notifier)
                                .remove(lawyer.id);
                          },
                        );
                      }).toList(),
                    ),

                  const SizedBox(height: AppSpacing.xxl),

                  // -----------------------------------------------------------
                  // Recently Viewed Law Firms
                  // -----------------------------------------------------------
                  _SectionHeader(
                    title: 'Recently Viewed Law Firms',
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: AppSpacing.md),

                  if (recentlyViewedFirms.isEmpty)
                    _SectionEmptyState(
                      icon: Icons.business_outlined,
                      message:
                          'No recently viewed law firms yet. '
                          'Firms you view will appear here.',
                      colorScheme: colorScheme,
                    )
                  else
                    Column(
                      children: recentlyViewedFirms.map((firm) {
                        return _RemovableFirmRow(
                          key: ValueKey('firm_${firm.id}'),
                          firm: firm,
                          onRemove: () {
                            ref
                                .read(recentlyViewedFirmsProvider.notifier)
                                .remove(firm.id);
                          },
                        );
                      }).toList(),
                    ),
                ],
              ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Section header
// -----------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  final String title;
  final ColorScheme colorScheme;

  const _SectionHeader({
    required this.title,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.headline.copyWith(
        color: colorScheme.onSurface,
        fontSize: 20,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Removable rows (header strip + existing card)
// -----------------------------------------------------------------------------

/// Wraps an existing [LawyerCard] with a small trailing remove action.
///
/// The card itself is not modified. The remove button sits in a small
/// header row above the card so the existing card layout is preserved.
class _RemovableLawyerRow extends StatelessWidget {
  final Lawyer lawyer;
  final VoidCallback onRemove;

  const _RemovableLawyerRow({
    super.key,
    required this.lawyer,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.sm,
              right: AppSpacing.xs,
              bottom: AppSpacing.xs,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Recently viewed',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onRemove,
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                  ),
                  label: Text(
                    'Remove',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          LawyerCard(lawyer: lawyer),
        ],
      ),
    );
  }
}

/// Wraps an existing [LawFirmCard] with a small trailing remove action.
///
/// The card itself is not modified.
class _RemovableFirmRow extends StatelessWidget {
  final LawFirm firm;
  final VoidCallback onRemove;

  const _RemovableFirmRow({
    super.key,
    required this.firm,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.sm,
              right: AppSpacing.xs,
              bottom: AppSpacing.xs,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Recently viewed',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onRemove,
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                  ),
                  label: Text(
                    'Remove',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          LawFirmCard(firm: firm),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Empty states
// -----------------------------------------------------------------------------

class _SectionEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final ColorScheme colorScheme;

  const _SectionEmptyState({
    required this.icon,
    required this.message,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
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
            icon,
            color: colorScheme.onSurfaceVariant,
            size: 24,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              message,
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

class _BothEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Container(
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
                  'Lawyers and law firms you view will appear here '
                  'for quick access.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
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
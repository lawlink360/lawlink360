import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/copy_house_chart_data.dart';

/// Shared layout for a Copy House payment chart screen.
///
/// Renders a single chart with:
///   - Title / subtitle
///   - Initial advance table + total
///   - After-confirmation caption and charges
///   - Regular / Urgent completion estimates
///   - Payment terms
///   - Payment disclaimer
///
/// Scrollable end-to-end so it never overflows on small phones.
/// All rows wrap rather than horizontally scroll.
class CopyHouseChartLayout extends StatelessWidget {
  final CopyHouseChartData chart;

  const CopyHouseChartLayout({
    super.key,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Payment Chart',
          style: AppTextStyles.title.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            chart.title,
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            chart.subtitle,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ----- Initial advance -------------------------------------
          _SectionHeading(
            title: 'Initial Advance Payments',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _FeeTable(rows: chart.initialAdvanceRows),
          const SizedBox(height: AppSpacing.sm),
          _TotalRow(
            label: chart.totalInitialAdvanceLabel,
            amount: chart.totalInitialAdvanceAmount,
            colorScheme: colorScheme,
          ),

          const SizedBox(height: AppSpacing.lg),

          // ----- After confirmation ----------------------------------
          _SectionHeading(
            title: 'Charges After Confirmation',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            chart.afterConfirmationCaption,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _FeeTable(rows: chart.afterConfirmationRows),

          const SizedBox(height: AppSpacing.lg),

          // ----- Estimated completion --------------------------------
          _SectionHeading(
            title: 'Estimated Completion Time',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _EstimateCard(
            title: 'Regular Application',
            detail: chart.regularEstimate,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          _EstimateCard(
            title: 'Urgent Application',
            detail: chart.urgentEstimate,
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            chart.completionNotice,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // ----- Payment terms ---------------------------------------
          _SectionHeading(
            title: 'Payment Terms',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var i = 0; i < chart.paymentTerms.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _NumberedItem(
                index: i + 1,
                text: chart.paymentTerms[i],
                colorScheme: colorScheme,
              ),
            ),

          const SizedBox(height: AppSpacing.lg),

          // ----- Disclaimer ------------------------------------------
          _SectionHeading(
            title: 'Payment Disclaimer',
            colorScheme: colorScheme,
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: colorScheme.error.withValues(alpha: 0.35),
              ),
            ),
            child: Text(
              chart.disclaimer,
              style: AppTextStyles.caption.copyWith(
                color: colorScheme.onSurface,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------

class _SectionHeading extends StatelessWidget {
  final String title;
  final ColorScheme colorScheme;

  const _SectionHeading({
    required this.title,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.body.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }
}

class _FeeTable extends StatelessWidget {
  final List<CopyHouseChartRow> rows;

  const _FeeTable({required this.rows});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            _FeeRow(row: rows[i], colorScheme: colorScheme),
            if (i < rows.length - 1)
              Divider(
                height: 1,
                color: colorScheme.outlineVariant
                    .withValues(alpha: 0.45),
              ),
          ],
        ],
      ),
    );
  }
}

class _FeeRow extends StatelessWidget {
  final CopyHouseChartRow row;
  final ColorScheme colorScheme;

  const _FeeRow({
    required this.row,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              row.label,
              style: AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurface,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            row.amount,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String amount;
  final ColorScheme colorScheme;

  const _TotalRow({
    required this.label,
    required this.amount,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            amount,
            style: AppTextStyles.body.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EstimateCard extends StatelessWidget {
  final String title;
  final String detail;
  final ColorScheme colorScheme;

  const _EstimateCard({
    required this.title,
    required this.detail,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.body.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberedItem extends StatelessWidget {
  final int index;
  final String text;
  final ColorScheme colorScheme;

  const _NumberedItem({
    required this.index,
    required this.text,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
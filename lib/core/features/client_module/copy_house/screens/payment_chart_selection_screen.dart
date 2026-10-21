import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/copy_house/screens/chart/district_court_chart_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/chart/high_court_chart_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/chart/mutation_chart_screen.dart';
import 'package:lawlink360/core/features/client_module/copy_house/screens/chart/registered_documents_chart_screen.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

class PaymentChartSelectionScreen extends StatelessWidget {
  const PaymentChartSelectionScreen({super.key});

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
            'Select a chart',
            style: AppTextStyles.title.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Each chart is informational only. It does not submit a '
            'request or process a payment.',
            style: AppTextStyles.caption.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _ChartOption(
            title: 'District Court Copy Charges Chart',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const DistrictCourtChartScreen(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ChartOption(
            title: 'High Court Copy Charges Chart',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HighCourtChartScreen(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ChartOption(
            title: 'Mutation Copy Charges Chart',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MutationChartScreen(),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ChartOption(
            title: 'Registered Documents Copy Charges Chart',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const RegisteredDocumentsChartScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ChartOption({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                color: colorScheme.primary,
                size: 22,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.42),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/procedure_model.dart';
import '../providers/recent_procedures_provider.dart';
import '../screens/procedure_detail_screen.dart';
import '../screens/recent_procedures_screen.dart';
import '../../../../../core/repositories/procedure_repository.dart';
import 'procedure_card.dart';

/// Home-screen "Recently Viewed" section.
///
/// Shows at most [_homeDisplayLimit] valid, resolvable procedures from
/// the persisted recent-history list. Provides a "View All" action that
/// opens the dedicated [RecentProceduresScreen]. Silently skips stale
/// ids that no longer resolve against the current procedure catalogue.
class RecentlyViewedProcedures extends ConsumerWidget {
  const RecentlyViewedProcedures({super.key});

  static const int _homeDisplayLimit = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentIds = ref.watch(recentProceduresProvider);

    final repository = const ProcedureRepository();
    final resolved = <ProcedureModel>[];
    for (final id in recentIds) {
      final procedure = repository.getProcedureById(id);
      if (procedure != null) resolved.add(procedure);
    }

    final displayed = resolved.take(_homeDisplayLimit).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Recently Viewed',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecentProceduresScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: AppSpacing.xs,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (displayed.isEmpty)
            const _RecentlyViewedEmptyState()
          else
            Column(
              children: [
                for (int i = 0; i < displayed.length; i++) ...[
                  ProcedureCard(
                    title: displayed[i].title,
                    overview: displayed[i].overview,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProcedureDetailScreen(
                            procedure: displayed[i],
                          ),
                        ),
                      );
                    },
                  ),
                  if (i != displayed.length - 1)
                    const SizedBox(height: AppSpacing.sm),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _RecentlyViewedEmptyState extends StatelessWidget {
  const _RecentlyViewedEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.history_rounded,
              color: AppColors.primary,
              size: 23,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No recent procedures yet',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Procedures you open will appear here for quick access.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
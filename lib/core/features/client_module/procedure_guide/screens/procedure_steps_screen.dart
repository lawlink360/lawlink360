import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/procedure_model.dart';
import '../widgets/procedure_step_tile.dart';

class ProcedureStepsScreen extends StatelessWidget {
  final ProcedureModel procedure;

  const ProcedureStepsScreen({
    super.key,
    required this.procedure,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          procedure.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.format_list_numbered,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '${procedure.steps.length} Steps to Complete This Procedure',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...procedure.steps.map(
            (step) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppSpacing.sm,
              ),
              child: ProcedureStepTile(
                stepNo: step.stepNo,
                title: step.title,
                description: step.description,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: AppSpacing.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check_circle_outline),
              label: Text(
                'Procedure Completed',
                style: AppTextStyles.button,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.textLight,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

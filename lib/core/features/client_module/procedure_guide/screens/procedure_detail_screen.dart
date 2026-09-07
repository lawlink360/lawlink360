import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../models/procedure_model.dart';
import '../widgets/estimated_time_card.dart';
import '../widgets/legal_notice_card.dart';
import '../widgets/related_laws_card.dart';
import '../widgets/required_documents_card.dart';
import 'procedure_steps_screen.dart';

import 'package:lawlink360/features/legal_navigator/enums/content_type.dart';
import 'package:lawlink360/features/legal_navigator/views/legal_navigator.dart';

class ProcedureDetailScreen extends StatelessWidget {
  final ProcedureModel procedure;

  const ProcedureDetailScreen({
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
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: AppColors.border,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  procedure.overview,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          RequiredDocumentsCard(
            documents: procedure.requiredDocuments,
          ),
          const SizedBox(height: AppSpacing.lg),
          EstimatedTimeCard(
            fee: procedure.estimatedFee,
            time: procedure.estimatedTime,
          ),
          const SizedBox(height: AppSpacing.lg),
          RelatedLawsCard(
            laws: procedure.applicableLaws,
          ),
          const SizedBox(height: AppSpacing.lg),
          const LegalNoticeCard(
            notice:
                'Always verify the latest legal requirements from the relevant authority before submitting documents.',
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: AppSpacing.buttonHeight,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: Text(
                'Start Step-by-Step Guide',
                style: AppTextStyles.button,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textLight,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProcedureStepsScreen(
                      procedure: procedure,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          LegalNavigator(
            contentType: ContentType.procedure,
            contentId: procedure.title,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

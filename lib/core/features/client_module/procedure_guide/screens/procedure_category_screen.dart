
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/procedure_data.dart';
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

  @override
  Widget build(BuildContext context) {
    final procedures = ProcedureData.procedures
        .where((p) => p.categoryId == categoryId)
        .toList();

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
      body: ListView.separated(
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
      ),
    );
  }
}

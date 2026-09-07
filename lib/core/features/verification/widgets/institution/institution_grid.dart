import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';

import 'package:lawlink360/core/features/verification/models/verification_subcategory.dart';
import 'package:lawlink360/core/features/verification/services/verification_data_service.dart';
import 'package:lawlink360/core/features/verification/screens/institution_screen.dart';
import 'package:lawlink360/core/features/verification/widgets/institution/institution_card.dart';

class InstitutionGrid extends StatelessWidget {
  final VerificationSubCategory subCategory;

  const InstitutionGrid({
    super.key,
    required this.subCategory,
  });

  @override
  Widget build(BuildContext context) {
    final institutions = VerificationDataService.getInstitutions(
      subCategory.id,
    );

    return ListView.builder(
      padding: const EdgeInsets.only(
        top: AppSpacing.xs,
        bottom: AppSpacing.xl,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: institutions.length,
      itemBuilder: (context, index) {
        final institution = institutions[index];

        return InstitutionCard(
          institution: institution,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => InstitutionScreen(
                  institution: institution,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
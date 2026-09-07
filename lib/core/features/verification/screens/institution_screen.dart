import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';

import '../models/verification_institution.dart';

import '../widgets/institution/institution_header.dart';
import '../widgets/services/service_grid.dart';

class InstitutionScreen extends StatelessWidget {
  final VerificationInstitution institution;

  const InstitutionScreen({
    super.key,
    required this.institution,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Column(
        children: [
          InstitutionHeader(
            institution: institution,
          ),
          Expanded(
            child: ServiceGrid(
              institutionId: institution.id,
            ),
          ),
        ],
      ),
    );
  }
}
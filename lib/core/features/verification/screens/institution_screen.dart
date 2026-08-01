import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            /// Institution Header
            InstitutionHeader(
              institution: institution,
            ),

            /// Services
            Expanded(
              child: ServiceGrid(
                institutionId: institution.id,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
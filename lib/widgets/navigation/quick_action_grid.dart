import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/scanner/screens/scanner_converter_home_screen.dart';
import 'package:lawlink360/core/features/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';
import '../cards/quick_action_card.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.72,
        children: [
          QuickActionCard(
            icon: Icons.gavel_rounded,
            title: 'Find Lawyer',
            subtitle: 'Search verified lawyers',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FindLawyerScreen(),
                ),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.description_rounded,
            title: 'Applications',
            subtitle: 'Draft legal applications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ApplicationHomeScreen(),
                ),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.translate_rounded,
            title: 'Translation',
            subtitle: 'Scan and translate documents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TranslationScreen(),
                ),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.document_scanner_rounded,
            title: 'Scanner',
            subtitle: 'Scan legal documents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScannerConverterHomeScreen(),
                ),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.verified_user_rounded,
            title: 'Verification Hub',
            subtitle: 'Government & Court Services',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VerificationScreen(),
                ),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.menu_book_rounded,
            title: 'Procedure Guider',
            subtitle: 'Legal process guidance',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const GuiderHomeScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
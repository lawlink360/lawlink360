import 'package:flutter/material.dart';

import 'package:lawlink360/widgets/cards/quick_action_card.dart';
import 'package:lawlink360/core/features/client_module/scanner/screens/scanner_converter_home_screen.dart';
import 'package:lawlink360/core/features/client_module/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/digital_clerk/screens/digital_clerk_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_clients/screens/lawyer_clients_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_drafting/screens/drafting_dashboard_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_law/screens/law_dashboard_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_judgments/screens/judgment_home_screen.dart';

class LawyerQuickActions extends StatelessWidget {
  const LawyerQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 18,
        childAspectRatio: 0.72,
        children: [
          QuickActionCard(
            icon: Icons.people_alt_rounded,
            title: 'Clients',
            subtitle: 'Manage your clients',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LawyerClientsScreen()),
              );
            },
          ),

          QuickActionCard(
            icon: Icons.assignment_ind_rounded,
            title: 'Digital Clerk',
            subtitle: 'Manage your legal work',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DigitalClerkScreen()),
              );
            },
          ),

          QuickActionCard(
            icon: Icons.menu_book_rounded,
            title: 'Laws',
            subtitle: 'Access legal resources',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LawDashboardScreen()),
              );
            },
          ),

          QuickActionCard(
            icon: Icons.edit_document,
            title: 'Drafting',
            subtitle: 'Prepare legal documents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DraftingDashboardScreen(),
                ),
              );
            },
          ),

          QuickActionCard(
            icon: Icons.gavel_rounded,
            title: 'Judgments',
            subtitle: 'Browse legal judgments',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const JudgmentHomeScreen()),
              );
            },
          ),

          QuickActionCard(
            icon: Icons.verified_user_rounded,
            title: 'Verification Hub',
            subtitle: 'Verify legal services',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VerificationScreen()),
              );
            },
          ),

          QuickActionCard(
            icon: Icons.translate_rounded,
            title: 'Translation',
            subtitle: 'Translate legal documents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TranslationScreen()),
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
            icon: Icons.description_rounded,
            title: 'Applications',
            subtitle: 'Prepare legal applications',
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
            icon: Icons.menu_book_rounded,
            title: "Procedure Guider",
            subtitle: "Legal process guidance",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GuiderHomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'quick_action_card.dart';
import 'package:lawlink360/core/features/scanner/screens/scanner_converter_home_screen.dart';
import 'package:lawlink360/core/features/client/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/translation/screens/image_translation_screen.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

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
            icon: Icons.gavel_rounded,
            title: "Find Lawyer",
            subtitle: "Search verified lawyers",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FindLawyerScreen()),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.description_rounded,
            title: "Applications",
            subtitle: "Draft legal applications",
            onTap: () {},
          ),
          QuickActionCard(
            icon: Icons.translate_rounded,
            title: "Translation",
            subtitle: "Translate documents",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TranslationScreen()),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.document_scanner,
            title: "Image Translation",
            subtitle: "Scan and translate documents",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImageTranslationScreen(),
                ),
              );
            },
          ),
          QuickActionCard(
            icon: Icons.document_scanner_rounded,
            title: "Scanner",
            subtitle: "Scan legal documents",
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
            title: "Verification",
            subtitle: "verify credentials",
            onTap: () {},
          ),
          QuickActionCard(
            icon: Icons.menu_book_rounded,
            title: "Pak Laws",
            subtitle: "Browse Pakistani laws",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

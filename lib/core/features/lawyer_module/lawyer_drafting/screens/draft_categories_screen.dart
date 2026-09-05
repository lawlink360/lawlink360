import 'package:flutter/material.dart';

import '../models/draft_category_model.dart';
import '../widgets/draft_category_card.dart';
import '../navigation/drafting_navigation.dart';

class DraftCategoriesScreen extends StatelessWidget {
  const DraftCategoriesScreen({super.key});

  static const Color navy = Color(0xFF13294B);
  static const Color gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    final categories = _categories;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      // ============================================================
      // APP BAR
      // ============================================================

      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Draft Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Choose Draft Type',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Select a category to start preparing your legal draft.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          // ========================================================
          // POPULAR CATEGORIES
          // ========================================================

          if (categories.any((category) => category.isPopular)) ...[
            const Text(
              'Popular',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),

            const SizedBox(height: 10),

            ...categories
                .where((category) => category.isPopular)
                .map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DraftCategoryCard(
                      category: category,
                      onTap: () {
                        _openCreateDraft(
                          context,
                          category,
                        );
                      },
                    ),
                  ),
                ),

            const SizedBox(height: 10),
          ],

          // ========================================================
          // ALL CATEGORIES
          // ========================================================

          const Text(
            'All Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: navy,
            ),
          ),

          const SizedBox(height: 10),

          ...categories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DraftCategoryCard(
                category: category,
                onTap: () {
                  _openCreateDraft(
                    context,
                    category,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // OPEN CREATE DRAFT
  // ==============================================================

  void _openCreateDraft(
    BuildContext context,
    DraftCategoryModel category,
  ) {
    Navigator.pushNamed(
      context,
      DraftingNavigation.createDraft,
      arguments: category.id,
    );
  }

  // ==============================================================
  // CATEGORIES
  // ==============================================================

  static const List<DraftCategoryModel> _categories = [
    DraftCategoryModel(
      id: 'applications',
      name: 'Applications',
      description: 'Prepare applications for courts and authorities.',
      iconName: 'application',
      draftCount: 12,
      isPopular: true,
    ),

    DraftCategoryModel(
      id: 'legal_notices',
      name: 'Legal Notices',
      description: 'Prepare formal legal notices and demands.',
      iconName: 'notice',
      draftCount: 8,
      isPopular: true,
    ),

    DraftCategoryModel(
      id: 'bail',
      name: 'Bail Applications',
      description: 'Prepare bail-related applications.',
      iconName: 'bail',
      draftCount: 6,
      isPopular: true,
    ),

    DraftCategoryModel(
      id: 'civil',
      name: 'Civil',
      description: 'Draft civil pleadings and applications.',
      iconName: 'civil',
      draftCount: 10,
    ),

    DraftCategoryModel(
      id: 'family',
      name: 'Family',
      description: 'Prepare family law related drafts.',
      iconName: 'family',
      draftCount: 7,
    ),

    DraftCategoryModel(
      id: 'criminal',
      name: 'Criminal',
      description: 'Prepare criminal law related drafts.',
      iconName: 'criminal',
      draftCount: 9,
    ),

    DraftCategoryModel(
      id: 'agreements',
      name: 'Agreements',
      description: 'Prepare agreements and legal arrangements.',
      iconName: 'agreement',
      draftCount: 5,
    ),

    DraftCategoryModel(
      id: 'petitions',
      name: 'Petitions',
      description: 'Prepare constitutional and legal petitions.',
      iconName: 'petition',
      draftCount: 4,
    ),

    DraftCategoryModel(
      id: 'contracts',
      name: 'Contracts',
      description: 'Prepare contracts and formal legal documents.',
      iconName: 'contract',
      draftCount: 3,
    ),
  ];
}
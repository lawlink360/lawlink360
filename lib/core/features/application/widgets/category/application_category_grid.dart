import 'package:flutter/material.dart';

import '../../models/document_category.dart';
import '../../services/document_data_service.dart';

import '../../screens/application_category_screen.dart';
import 'application_category_card.dart';

class ApplicationCategoryGrid extends StatelessWidget {
  const ApplicationCategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DocumentCategory> categories =
        DocumentDataService.categories;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Browse by Category',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 18),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];

              return ApplicationCategoryCard(
                title: category.title,
                description: category.description,
                icon: category.icon,
                color: category.color,
                templateCount: DocumentDataService
                    .getSubCategories(category.id)
                    .length,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ApplicationCategoryScreen(
                        category: category,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
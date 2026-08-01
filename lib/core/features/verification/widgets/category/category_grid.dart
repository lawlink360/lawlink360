import 'package:flutter/material.dart';

import 'category_card.dart';

import '../../models/verification_category.dart';
import '../../screens/category_services_screen.dart';
import '../../services/verification_data_service.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<VerificationCategory> categories =
        VerificationDataService.categories;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];

              return CategoryCard(
                title: category.title,
                description: category.description,
                icon: category.icon,
                color: category.color,
                serviceCount: VerificationDataService.getSubCategories(
                  category.id,
                ).length,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CategoryServicesScreen(category: category),
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

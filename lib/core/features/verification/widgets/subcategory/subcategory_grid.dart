import 'package:flutter/material.dart';

import '../../models/verification_subcategory.dart';
import '../../screens/subcategory_screen.dart';
import 'package:lawlink360/core/features/verification/widgets/subcategory/subcatagory_card.dart';

class SubCategoryGrid extends StatelessWidget {
  final List<VerificationSubCategory> subCategories;

  const SubCategoryGrid({
    super.key,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 30),
      itemCount: subCategories.length,
      itemBuilder: (context, index) {
        final subCategory = subCategories[index];

        return SubCategoryCard(
          subCategory: subCategory,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SubCategoryScreen(
                  subCategory: subCategory,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
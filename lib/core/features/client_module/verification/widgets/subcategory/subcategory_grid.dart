import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_spacing.dart';

import '../../models/verification_subcategory.dart';
import '../../screens/subcategory_screen.dart';
import 'subcatagory_card.dart';

class SubCategoryGrid extends StatelessWidget {
  final List<VerificationSubCategory> subCategories;

  const SubCategoryGrid({
    super.key,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: AppSpacing.xs,
        bottom: AppSpacing.xl,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: subCategories.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppSpacing.xs),
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
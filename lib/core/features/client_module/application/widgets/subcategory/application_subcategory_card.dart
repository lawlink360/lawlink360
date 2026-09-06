import 'package:flutter/material.dart';

import '../../models/document_subcategory.dart';

class ApplicationSubCategoryCard extends StatelessWidget {
  final DocumentSubCategory subCategory;
  final VoidCallback? onTap;

  const ApplicationSubCategoryCard({
    super.key,
    required this.subCategory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    subCategory.color.withValues(alpha:0.15),
                child: Icon(
                  subCategory.icon,
                  color: subCategory.color,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      subCategory.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subCategory.description,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Text(
                    "${subCategory.templateCount}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: subCategory.color,
                    ),
                  ),

                  const Text(
                    "Templates",
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
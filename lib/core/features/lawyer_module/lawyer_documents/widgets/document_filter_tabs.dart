import 'package:flutter/material.dart';

class DocumentFilterTabs extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const DocumentFilterTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  static const List<String> categories = [
    'All',
    'Drafts',
    'Client Files',
    'Saved',
    'PDF',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onCategoryChanged(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF13294B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF13294B)
                      : Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF374151),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
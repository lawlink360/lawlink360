import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/procedure_data.dart';
import '../widgets/guider_header.dart';
import '../widgets/guider_search_bar.dart';
import '../widgets/procedure_category_card.dart';
import 'procedure_category_screen.dart';

class GuiderHomeScreen extends StatefulWidget {
  const GuiderHomeScreen({super.key});

  @override
  State<GuiderHomeScreen> createState() => _GuiderHomeScreenState();
}

class _GuiderHomeScreenState extends State<GuiderHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {}

  @override
  Widget build(BuildContext context) {
    final categories = ProcedureData.categories;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Procedure Guider',
          style: AppTextStyles.title.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          bottom: AppSpacing.xl,
        ),
        children: [
          const GuiderHeader(),
          GuiderSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
            ),
            child: Column(
              children: categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.sm,
                  ),
                  child: ProcedureCategoryCard(
                    icon: category.icon,
                    color: category.color,
                    title: category.title,
                    description: category.description,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProcedureCategoryScreen(
                            categoryId: category.id,
                            title: category.title,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

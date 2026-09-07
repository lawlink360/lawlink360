import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../models/verification_subcategory.dart';
import '../models/verification_institution.dart';
import '../services/verification_data_service.dart';
import '../widgets/services/category_service_header.dart';
import '../widgets/services/category_service_search.dart';
import '../widgets/institution/institution_card.dart';
import 'institution_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  final VerificationSubCategory subCategory;

  const SubCategoryScreen({
    super.key,
    required this.subCategory,
  });

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  late List<VerificationInstitution> allInstitutions;
  late List<VerificationInstitution> filteredInstitutions;

  @override
  void initState() {
    super.initState();

    allInstitutions = VerificationDataService.getInstitutions(
      widget.subCategory.id,
    );

    filteredInstitutions = List.from(allInstitutions);
  }

  void _search(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        filteredInstitutions = List.from(allInstitutions);
      } else {
        final query = value.trim().toLowerCase();

        filteredInstitutions = allInstitutions.where((item) {
          return item.title.toLowerCase().contains(query) ||
              item.description.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = VerificationDataService.getCategory(
      widget.subCategory.categoryId,
    );

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Column(
        children: [
          CategoryServiceHeader(
            category: category!,
            totalServices: allInstitutions.length,
          ),
          CategoryServiceSearch(
            controller: _searchController,
            onChanged: _search,
          ),
          Expanded(
            child: filteredInstitutions.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.06),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search_off_rounded,
                              size: 34,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No Institutions Found',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'No institutions match your search.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.xs,
                      bottom: AppSpacing.xl,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredInstitutions.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.xs),
                    itemBuilder: (context, index) {
                      final institution = filteredInstitutions[index];

                      return InstitutionCard(
                        institution: institution,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => InstitutionScreen(
                                institution: institution,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
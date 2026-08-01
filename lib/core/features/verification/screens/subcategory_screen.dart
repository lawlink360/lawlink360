import 'package:flutter/material.dart';

import '../models/verification_subcategory.dart';
import '../models/verification_institution.dart';
import '../services/verification_data_service.dart';
import '../widgets/services/category_service_header.dart';
import '../widgets/services/category_service_search.dart';
import '../widgets/institution/institution_card.dart';
import 'institution_screen.dart';

class SubCategoryScreen extends StatefulWidget {
  final VerificationSubCategory subCategory;

  const SubCategoryScreen({super.key, required this.subCategory});

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
        filteredInstitutions = allInstitutions.where((item) {
          return item.title.toLowerCase().contains(value.toLowerCase()) ||
              item.description.toLowerCase().contains(value.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            CategoryServiceHeader(
              category: VerificationDataService.getCategory(
                widget.subCategory.categoryId,
              )!,
              totalServices: allInstitutions.length,
            ),

            CategoryServiceSearch(
              controller: _searchController,
              onChanged: _search,
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 30),
                itemCount: filteredInstitutions.length,
                itemBuilder: (context, index) {
                  final institution = filteredInstitutions[index];

                  return InstitutionCard(
                    institution: institution,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              InstitutionScreen(institution: institution),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

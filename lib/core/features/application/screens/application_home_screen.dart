import 'package:flutter/material.dart';

import '../widgets/category/application_header_section.dart';
import '../widgets/category/application_search_bar.dart';
import '../widgets/category/application_statistics_cards.dart';
import '../widgets/category/application_important_notice.dart';
import '../widgets/category/application_category_grid.dart';
import '../widgets/category/application_recent_documents.dart';

class ApplicationHomeScreen extends StatelessWidget {
  const ApplicationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              /// Header
              ApplicationHeaderSection(),

              SizedBox(height: 18),

              /// Search
              ApplicationSearchBar(),

              SizedBox(height: 20),

              /// Statistics
              ApplicationStatisticsCards(),

              SizedBox(height: 22),

              /// Categories
              ApplicationCategoryGrid(),

              SizedBox(height: 24),

              /// Recent Documents
              ApplicationRecentDocuments(),

              SizedBox(height: 30),

              /// Important Notice
              ApplicationImportantNotice(),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
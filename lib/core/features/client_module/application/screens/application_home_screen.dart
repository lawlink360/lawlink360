
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';

import '../widgets/category/application_category_grid.dart';
import '../widgets/category/application_header_section.dart';
import '../widgets/category/application_important_notice.dart';
import '../widgets/category/application_recent_documents.dart';
import '../widgets/category/application_search_bar.dart';
import '../widgets/category/application_statistics_cards.dart';

class ApplicationHomeScreen extends StatelessWidget {
  const ApplicationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ApplicationHeaderSection(),
              const SizedBox(height: AppSpacing.md),
              const ApplicationSearchBar(),
              const SizedBox(height: AppSpacing.lg),
              const ApplicationStatisticsCards(),
              const SizedBox(height: AppSpacing.lg),
              const ApplicationCategoryGrid(),
              const SizedBox(height: AppSpacing.xl),
              const ApplicationRecentDocuments(),
              const SizedBox(height: AppSpacing.xl),
              const ApplicationImportantNotice(),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/case_data.dart';
import '../widgets/case_card.dart';
import '../widgets/case_filter_tabs.dart';
import '../widgets/case_search_bar.dart';
import '../widgets/case_statistics_card.dart';

class MyCasesScreen extends StatefulWidget {
  const MyCasesScreen({super.key});

  @override
  State<MyCasesScreen> createState() => _MyCasesScreenState();
}

class _MyCasesScreenState extends State<MyCasesScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'My Cases',
          style: AppTextStyles.title.copyWith(
            color: AppColors.lightTextPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const CaseSearchBar(),

          const SizedBox(height: AppSpacing.lg),

          Row(
            children: const [
              CaseStatisticsCards(
                title: 'Active',
                value: '1',
                icon: Icons.gavel_outlined,
                color: AppColors.success,
              ),
              SizedBox(width: AppSpacing.sm),
              CaseStatisticsCards(
                title: 'Pending',
                value: '1',
                icon: Icons.schedule_rounded,
                color: AppColors.warning,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.sm),

          Row(
            children: const [
              CaseStatisticsCards(
                title: 'Completed',
                value: '1',
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.info,
              ),
              SizedBox(width: AppSpacing.sm),
              CaseStatisticsCards(
                title: 'Archived',
                value: '1',
                icon: Icons.archive_outlined,
                color: AppColors.lightTextSecondary,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Case Status',
            style: AppTextStyles.title.copyWith(
              color: AppColors.lightTextPrimary,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          CaseFilterTabs(
            selectedIndex: selectedTab,
            onChanged: (index) {
              setState(() {
                selectedTab = index;
              });
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          ...CaseData.cases.map(
            (item) => CaseCard(
              caseItem: item,
            ),
          ),

          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
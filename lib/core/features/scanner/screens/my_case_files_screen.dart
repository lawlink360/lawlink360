import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_radius.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../widgets/my_case_folder_card.dart';

class MyCaseFilesScreen extends StatelessWidget {
  const MyCaseFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'My Case Files',
          style: AppTextStyles.title.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          100,
        ),
        children: [
          MyCaseFolderCard(
            title: 'Property Dispute',
            subtitle: 'Lahore High Court',
            documents: 12,
            onTap: () {},
          ),
          MyCaseFolderCard(
            title: 'Family Matter',
            subtitle: 'Family Court',
            documents: 5,
            onTap: () {},
          ),
          MyCaseFolderCard(
            title: 'Criminal Case',
            subtitle: 'Sessions Court',
            documents: 8,
            onTap: () {},
          ),
          MyCaseFolderCard(
            title: 'Personal Documents',
            subtitle: 'CNIC • Passport • Certificates',
            documents: 15,
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textLight,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create New Case File (Coming Next)'),
            ),
          );
        },
        icon: const Icon(
          Icons.create_new_folder_outlined,
        ),
        label: Text(
          'New Case',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textLight,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/theme/app_colors.dart';
import 'package:lawlink360/core/theme/app_spacing.dart';
import 'package:lawlink360/core/theme/app_text_styles.dart';

import '../data/document_data.dart';
import '../widgets/document_card.dart';
import '../widgets/documents_filter_tabs.dart';
import '../widgets/document_search_bar.dart';
import '../widgets/document_statistics_cards.dart';
import '../widgets/empty_documents_widget.dart';
import '../widgets/recent_documents_card.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final documents = DocumentData.documents;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'My Documents',
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
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const DocumentSearchBar(),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: const [
                Expanded(
                  child: DocumentStatisticsCards(
                    title: 'Documents',
                    value: '3',
                    icon: Icons.folder,
                    color: AppColors.info,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: DocumentStatisticsCards(
                    title: 'Favorites',
                    value: '2',
                    icon: Icons.star,
                    color: AppColors.warning,
                  ),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: DocumentStatisticsCards(
                    title: 'Verified',
                    value: '1',
                    icon: Icons.verified,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            DocumentFilterTabs(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            const RecentDocumentsCard(),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: documents.isEmpty
                  ? const EmptyDocumentsWidget()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: documents.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        return DocumentCard(
                          document: documents[index],
                          onTap: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

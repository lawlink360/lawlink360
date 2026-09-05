import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/providers/admin_content_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/screens/admin_drafting_content_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/screens/admin_judgments_content_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/screens/admin_laws_content_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/screens/admin_procedures_content_screen.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/widgets/admin_content_card.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/widgets/content_status_chip.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminContentScreen extends ConsumerWidget {
  const AdminContentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentState = ref.watch(adminContentProvider);
    final contentNotifier = ref.read(adminContentProvider.notifier);

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Content Management',
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AdminDrawer(
        selectedIndex: 10,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: contentState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Unable to load content.\n$error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (contents) {
          return RefreshIndicator(
            onRefresh: contentNotifier.refresh,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildOverview(
                  context,
                  contentNotifier,
                ),
                const SizedBox(height: 20),
                _buildCategoryNavigation(context),
                const SizedBox(height: 20),
                _buildFilters(
                  context,
                  ref,
                  contentNotifier,
                ),
                const SizedBox(height: 16),
                if (contents.isEmpty)
                  _buildEmptyState(context)
                else
                  ...contents.map(
                    (content) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: AdminContentCard(
                        content: content,
                        onTap: () {},
                        onEdit: () {},
                        onDelete: () {
                          contentNotifier.deleteContent(content.id);
                        },
                        onStatusChanged: () {
                          _showStatusDialog(
                            context,
                            contentNotifier,
                            content.id,
                            content.status,
                          );
                        },
                        onFeaturedToggle: () {
                          contentNotifier.toggleFeatured(content.id);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverview(
    BuildContext context,
    dynamic notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Content Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.65,
          children: [
            _StatCard(
              title: 'Total',
              value: notifier.totalContents,
              icon: Icons.library_books_outlined,
            ),
            _StatCard(
              title: 'Published',
              value: notifier.publishedContents,
              icon: Icons.check_circle_outline,
            ),
            _StatCard(
              title: 'Drafts',
              value: notifier.draftContents,
              icon: Icons.edit_note_outlined,
            ),
            _StatCard(
              title: 'Scheduled',
              value: notifier.scheduledContents,
              icon: Icons.schedule_outlined,
            ),
            _StatCard(
              title: 'Archived',
              value: notifier.archivedContents,
              icon: Icons.archive_outlined,
            ),
            _StatCard(
              title: 'Featured',
              value: notifier.featuredContents,
              icon: Icons.star_outline,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryNavigation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Content Sections',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _SectionButton(
                icon: Icons.gavel_outlined,
                label: 'Laws',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminLawsContentScreen(),
                    ),
                  );
                },
              ),
              _SectionButton(
                icon: Icons.balance_outlined,
                label: 'Judgments',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const AdminJudgmentsContentScreen(),
                    ),
                  );
                },
              ),
              _SectionButton(
                icon: Icons.edit_document,
                label: 'Drafting',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const AdminDraftingContentScreen(),
                    ),
                  );
                },
              ),
              _SectionButton(
                icon: Icons.account_tree_outlined,
                label: 'Procedures',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const AdminProceduresContentScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(
    BuildContext context,
    WidgetRef ref,
    dynamic notifier,
  ) {
    final List<String> categories =
        List<String>.from(notifier.categories);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter Content',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          onChanged: notifier.search,
          decoration: InputDecoration(
            hintText: 'Search content...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: notifier.searchQuery.isNotEmpty
                ? IconButton(
                    onPressed: () => notifier.search(''),
                    icon: const Icon(Icons.clear),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: notifier.categoryFilter,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: categories
                    .map<DropdownMenuItem<String>>(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    notifier.setCategoryFilter(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: notifier.statusFilter,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: [
                  'All',
                  ContentStatus.draft.label,
                  ContentStatus.published.label,
                  ContentStatus.scheduled.label,
                  ContentStatus.archived.label,
                ]
                    .map<DropdownMenuItem<String>>(
                      (status) => DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    notifier.setStatusFilter(value);
                  }
                },
              ),
            ),
          ],
        ),
        if (notifier.searchQuery.isNotEmpty ||
            notifier.categoryFilter != 'All' ||
            notifier.statusFilter != 'All') ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: notifier.clearFilters,
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear Filters'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context)
              .dividerColor
              .withValues(alpha: 0.5),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 48,
          ),
          SizedBox(height: 12),
          Text(
            'No content found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _showStatusDialog(
    BuildContext context,
    dynamic notifier,
    String contentId,
    ContentStatus currentStatus,
  ) async {
    final selectedStatus = await showDialog<ContentStatus>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Change Content Status'),
          children: ContentStatus.values.map((status) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, status),
              child: Row(
                children: [
                  ContentStatusChip(
                    status: status,
                    compact: true,
                  ),
                  const SizedBox(width: 12),
                  if (status == currentStatus)
                    const Icon(
                      Icons.check,
                      size: 18,
                    ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );

    if (selectedStatus != null) {
      notifier.setContentStatus(
        contentId,
        selectedStatus,
      );
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: theme.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.35),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.textTheme.bodySmall?.color
                        ?.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SectionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/providers/admin_content_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/widgets/admin_content_card.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminDraftingContentScreen extends ConsumerWidget {
  const AdminDraftingContentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminContentProvider);
    final notifier = ref.read(adminContentProvider.notifier);

    final draftingContents = notifier.contents
        .where(
          (content) =>
              content.category.toLowerCase() == 'drafting',
        )
        .toList();

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Drafting Content',
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AdminDrawer(
        selectedIndex: 10,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Unable to load drafting content.\n$error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (_) {
          if (draftingContents.isEmpty) {
            return const Center(
              child: Text('No drafting content available.'),
            );
          }

          return RefreshIndicator(
            onRefresh: notifier.refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: draftingContents.length,
              itemBuilder: (context, index) {
                final content = draftingContents[index];

                return AdminContentCard(
                  content: content,
                  onTap: () {},
                  onEdit: () {},
                  onDelete: () {
                    notifier.deleteContent(content.id);
                  },
                  onStatusChanged: () {
                    _showStatusDialog(
                      context,
                      notifier,
                      content.id,
                      content.status,
                    );
                  },
                  onFeaturedToggle: () {
                    notifier.toggleFeatured(content.id);
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Draft'),
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
          title: const Text('Change Status'),
          children: ContentStatus.values.map((status) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, status);
              },
              child: Row(
                children: [
                  Icon(
                    status.icon,
                    color: status.color,
                  ),
                  const SizedBox(width: 10),
                  Text(status.label),
                  const Spacer(),
                  if (status == currentStatus)
                    const Icon(Icons.check),
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
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';

class ContentActionMenu extends StatelessWidget {
  final ContentStatus status;
  final bool isFeatured;
  final VoidCallback? onEdit;
  final VoidCallback? onPublish;
  final VoidCallback? onSchedule;
  final VoidCallback? onArchive;
  final VoidCallback? onRestore;
  final VoidCallback? onToggleFeatured;
  final VoidCallback? onDelete;

  const ContentActionMenu({
    super.key,
    required this.status,
    this.isFeatured = false,
    this.onEdit,
    this.onPublish,
    this.onSchedule,
    this.onArchive,
    this.onRestore,
    this.onToggleFeatured,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Content actions',
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit?.call();
            break;
          case 'publish':
            onPublish?.call();
            break;
          case 'schedule':
            onSchedule?.call();
            break;
          case 'archive':
            onArchive?.call();
            break;
          case 'restore':
            onRestore?.call();
            break;
          case 'featured':
            onToggleFeatured?.call();
            break;
          case 'delete':
            onDelete?.call();
            break;
        }
      },
      itemBuilder: (context) {
        final items = <PopupMenuEntry<String>>[
          const PopupMenuItem(
            value: 'edit',
            child: ListTile(
              leading: Icon(Icons.edit_outlined),
              title: Text('Edit Content'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ];

        if (status == ContentStatus.draft ||
            status == ContentStatus.archived) {
          items.add(
            const PopupMenuItem(
              value: 'publish',
              child: ListTile(
                leading: Icon(Icons.publish_outlined),
                title: Text('Publish'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          );
        }

        if (status == ContentStatus.draft) {
          items.add(
            const PopupMenuItem(
              value: 'schedule',
              child: ListTile(
                leading: Icon(Icons.schedule_outlined),
                title: Text('Schedule'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          );
        }

        if (status == ContentStatus.published ||
            status == ContentStatus.scheduled) {
          items.add(
            const PopupMenuItem(
              value: 'archive',
              child: ListTile(
                leading: Icon(Icons.archive_outlined),
                title: Text('Archive'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          );
        }

        if (status == ContentStatus.archived) {
          items.add(
            const PopupMenuItem(
              value: 'restore',
              child: ListTile(
                leading: Icon(Icons.restore_outlined),
                title: Text('Restore to Draft'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          );
        }

        items.add(
          PopupMenuItem(
            value: 'featured',
            child: ListTile(
              leading: Icon(
                isFeatured
                    ? Icons.star_border
                    : Icons.star_outline,
              ),
              title: Text(
                isFeatured
                    ? 'Remove Featured'
                    : 'Mark as Featured',
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        );

        items.add(const PopupMenuDivider());

        items.add(
          const PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              title: Text('Delete'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        );

        return items;
      },
    );
  }
}
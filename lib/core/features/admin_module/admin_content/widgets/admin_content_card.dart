import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_content/models/admin_content_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/widgets/content_status_chip.dart';
import 'package:lawlink360/core/features/admin_module/admin_content/models/content_status_model.dart';

class AdminContentCard extends StatelessWidget {
  final AdminContentModel content;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onStatusChanged;
  final VoidCallback? onFeaturedToggle;

  const AdminContentCard({
    super.key,
    required this.content,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onStatusChanged,
    this.onFeaturedToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context)
              .dividerColor
              .withValues(alpha: 0.6),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (content.isFeatured) ...[
                              const Icon(
                                Icons.star,
                                size: 17,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 5),
                            ],
                            Expanded(
                              child: Text(
                                content.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          content.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  PopupMenuButton<String>(
                    tooltip: 'Content actions',
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit?.call();
                          break;
                        case 'status':
                          onStatusChanged?.call();
                          break;
                        case 'featured':
                          onFeaturedToggle?.call();
                          break;
                        case 'delete':
                          onDelete?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Edit'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'status',
                        child: ListTile(
                          leading: Icon(content.status.icon),
                          title: Text(
                            content.status == ContentStatus.published
                                ? 'Change Status'
                                : 'Update Status',
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'featured',
                        child: ListTile(
                          leading: Icon(
                            content.isFeatured
                                ? Icons.star_border
                                : Icons.star_outline,
                          ),
                          title: Text(
                            content.isFeatured
                                ? 'Remove Featured'
                                : 'Mark Featured',
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuDivider(),
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
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ContentStatusChip(
                    status: content.status,
                    compact: true,
                  ),
                  _InfoChip(
                    icon: Icons.folder_outlined,
                    label: content.category,
                  ),
                  _InfoChip(
                    icon: Icons.person_outline,
                    label: content.authorName,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  _StatItem(
                    icon: Icons.visibility_outlined,
                    value: content.viewCount,
                  ),
                  const SizedBox(width: 16),
                  _StatItem(
                    icon: Icons.favorite_border,
                    value: content.likeCount,
                  ),
                  const SizedBox(width: 16),
                  _StatItem(
                    icon: Icons.share_outlined,
                    value: content.shareCount,
                  ),
                  const Spacer(),
                  if (content.publishedAt != null)
                    Text(
                      _formatDate(content.publishedAt!),
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color
                            ?.withValues(alpha: 0.65),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context)
                .iconTheme
                .color
                ?.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 130,
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int value;

  const _StatItem({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 15,
          color: Theme.of(context)
              .iconTheme
              .color
              ?.withValues(alpha: 0.65),
        ),
        const SizedBox(width: 4),
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context)
                .textTheme
                .bodySmall
                ?.color
                ?.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}
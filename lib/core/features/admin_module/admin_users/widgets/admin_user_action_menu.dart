import 'package:flutter/material.dart';

class AdminUserActionMenu extends StatelessWidget {
  final VoidCallback? onViewDetails;
  final VoidCallback? onViewActivity;
  final VoidCallback? onActivate;
  final VoidCallback? onSuspend;
  final VoidCallback? onDeactivate;

  const AdminUserActionMenu({
    super.key,
    this.onViewDetails,
    this.onViewActivity,
    this.onActivate,
    this.onSuspend,
    this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'User actions',
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'details':
            onViewDetails?.call();
            break;
          case 'activity':
            onViewActivity?.call();
            break;
          case 'activate':
            onActivate?.call();
            break;
          case 'suspend':
            onSuspend?.call();
            break;
          case 'deactivate':
            onDeactivate?.call();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'details',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.person_outline),
              title: Text('View Details'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'activity',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.history),
              title: Text('View Activity'),
            ),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem<String>(
            value: 'activate',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle_outline),
              title: Text('Activate'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'suspend',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.block_outlined),
              title: Text('Suspend'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'deactivate',
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.pause_circle_outline),
              title: Text('Deactivate'),
            ),
          ),
        ];
      },
    );
  }
}
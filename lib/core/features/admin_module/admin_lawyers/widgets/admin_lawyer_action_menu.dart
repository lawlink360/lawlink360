import 'package:flutter/material.dart';

class AdminLawyerActionMenu extends StatelessWidget {
  final VoidCallback? onViewDetails;
  final VoidCallback? onViewPerformance;
  final VoidCallback? onApprove;
  final VoidCallback? onActivate;
  final VoidCallback? onSuspend;
  final VoidCallback? onDeactivate;

  const AdminLawyerActionMenu({
    super.key,
    this.onViewDetails,
    this.onViewPerformance,
    this.onApprove,
    this.onActivate,
    this.onSuspend,
    this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'details':
            onViewDetails?.call();
            break;

          case 'performance':
            onViewPerformance?.call();
            break;

          case 'approve':
            onApprove?.call();
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
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'details',
          child: ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('View Details'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'performance',
          child: ListTile(
            leading: Icon(Icons.analytics_outlined),
            title: Text('View Performance'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        if (onApprove != null)
          const PopupMenuItem<String>(
            value: 'approve',
            child: ListTile(
              leading: Icon(Icons.verified_outlined),
              title: Text('Approve'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        const PopupMenuDivider(),
        if (onActivate != null)
          const PopupMenuItem<String>(
            value: 'activate',
            child: ListTile(
              leading: Icon(Icons.play_circle_outline),
              title: Text('Activate'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        if (onSuspend != null)
          const PopupMenuItem<String>(
            value: 'suspend',
            child: ListTile(
              leading: Icon(Icons.block_outlined),
              title: Text('Suspend'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        if (onDeactivate != null)
          const PopupMenuItem<String>(
            value: 'deactivate',
            child: ListTile(
              leading: Icon(Icons.pause_circle_outline),
              title: Text('Deactivate'),
              contentPadding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }
}
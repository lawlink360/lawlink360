import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/models/admin_user_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/widgets/admin_user_action_menu.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/widgets/admin_user_status_chip.dart';

class AdminUserCard extends StatelessWidget {
  final AdminUserModel user;
  final VoidCallback? onViewDetails;
  final VoidCallback? onViewActivity;
  final VoidCallback? onActivate;
  final VoidCallback? onSuspend;
  final VoidCallback? onDeactivate;

  const AdminUserCard({
    super.key,
    required this.user,
    this.onViewDetails,
    this.onViewActivity,
    this.onActivate,
    this.onSuspend,
    this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(theme),
                const SizedBox(width: 12),
                Expanded(child: _buildUserInfo(theme)),
                AdminUserActionMenu(
                  onViewDetails: onViewDetails,
                  onViewActivity: onViewActivity,
                  onActivate: onActivate,
                  onSuspend: onSuspend,
                  onDeactivate: onDeactivate,
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 14),
            _buildContactInfo(theme),
            const SizedBox(height: 14),
            _buildUserStats(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme) {
    final initial = user.name.trim().isNotEmpty
        ? user.name.trim()[0].toUpperCase()
        : '?';

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.10),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (user.isVerified) ...[
              const SizedBox(width: 6),
              Icon(Icons.verified, size: 17, color: theme.colorScheme.primary),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          user.role.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            letterSpacing: 0.6,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),

        AdminUserStatusChip(status: user.status),
      ],
    );
  }

  Widget _buildContactInfo(ThemeData theme) {
    return Column(
      children: [
        _InfoRow(icon: Icons.email_outlined, text: user.email),
        const SizedBox(height: 8),
        _InfoRow(icon: Icons.phone_outlined, text: user.phone),
      ],
    );
  }

  Widget _buildUserStats(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.calendar_today_outlined,
            label: 'Appointments',
            value: user.appointmentsCount.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatItem(
            icon: Icons.folder_outlined,
            label: 'Active Cases',
            value: user.activeCasesCount.toString(),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.45,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 17, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

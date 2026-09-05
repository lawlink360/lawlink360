import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_users/providers/admin_user_details_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_users/widgets/admin_user_status_chip.dart';

class AdminUserDetailsScreen extends ConsumerWidget {
  final String userId;

  const AdminUserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(
      adminUserDetailsProvider(userId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: userState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => _buildError(
          context,
          ref,
          error.toString(),
        ),
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text('User not found.'),
            );
          }

          return _buildContent(
            context,
            ref,
            user,
          );
        },
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref,
    String message,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'Unable to load user details.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                ref
                    .read(
                      adminUserDetailsProvider(userId).notifier,
                    )
                    .refreshUser();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    dynamic user,
  ) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: () {
        return ref
            .read(
              adminUserDetailsProvider(userId).notifier,
            )
            .refreshUser();
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(
            context,
            user,
          ),
          const SizedBox(height: 16),
          _buildInformationCard(
            context,
            user,
          ),
          const SizedBox(height: 16),
          _buildActivitySummary(
            context,
            user,
          ),
          const SizedBox(height: 16),
          _buildStatusActions(
            context,
            ref,
            user,
          ),
          const SizedBox(height: 16),
          _buildAccountCard(
            context,
            user,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    dynamic user,
  ) {
    final theme = Theme.of(context);

    final initial = user.name.trim().isNotEmpty
        ? user.name.trim()[0].toUpperCase()
        : '?';

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(
                  alpha: 0.10,
                ),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              user.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.role.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                letterSpacing: 0.8,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            AdminUserStatusChip(
              status: user.status,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationCard(
    BuildContext context,
    dynamic user,
  ) {
    return _SectionCard(
      title: 'Contact Information',
      icon: Icons.contact_page_outlined,
      children: [
        _DetailRow(
          icon: Icons.email_outlined,
          label: 'Email',
          value: user.email,
        ),
        _DetailRow(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: user.phone,
        ),
      ],
    );
  }

  Widget _buildActivitySummary(
    BuildContext context,
    dynamic user,
  ) {
    return _SectionCard(
      title: 'Activity Summary',
      icon: Icons.insights_outlined,
      children: [
        _DetailRow(
          icon: Icons.calendar_today_outlined,
          label: 'Appointments',
          value: user.appointmentsCount.toString(),
        ),
        _DetailRow(
          icon: Icons.folder_outlined,
          label: 'Active Cases',
          value: user.activeCasesCount.toString(),
        ),
        _DetailRow(
          icon: Icons.verified_outlined,
          label: 'Verification',
          value: user.isVerified
              ? 'Verified'
              : 'Not Verified',
        ),
      ],
    );
  }

  Widget _buildStatusActions(
    BuildContext context,
    WidgetRef ref,
    dynamic user,
  ) {
    final notifier = ref.read(
      adminUserDetailsProvider(userId).notifier,
    );

    return _SectionCard(
      title: 'Account Status',
      icon: Icons.manage_accounts_outlined,
      children: [
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatusButton(
              label: 'Activate',
              icon: Icons.check_circle_outline,
              selected: user.status == 'active',
              onPressed: () {
                notifier.updateStatus('active');
              },
            ),
            _StatusButton(
              label: 'Deactivate',
              icon: Icons.pause_circle_outline,
              selected: user.status == 'inactive',
              onPressed: () {
                notifier.updateStatus('inactive');
              },
            ),
            _StatusButton(
              label: 'Suspend',
              icon: Icons.block_outlined,
              selected: user.status == 'suspended',
              onPressed: () {
                notifier.updateStatus('suspended');
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountCard(
    BuildContext context,
    dynamic user,
  ) {
    final theme = Theme.of(context);

    return _SectionCard(
      title: 'Account Information',
      icon: Icons.info_outline,
      children: [
        _DetailRow(
          icon: Icons.badge_outlined,
          label: 'User ID',
          value: user.id,
        ),
        _DetailRow(
          icon: Icons.calendar_month_outlined,
          label: 'Joined',
          value: _formatDate(user.joinedAt),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  const _StatusButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: selected ? null : onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(label),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_lawyers/models/admin_lawyer_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_action_menu.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/widgets/admin_lawyer_status_chip.dart';

class AdminLawyerCard extends StatelessWidget {
  final AdminLawyerModel lawyer;

  final VoidCallback? onViewDetails;
  final VoidCallback? onViewPerformance;
  final VoidCallback? onApprove;
  final VoidCallback? onActivate;
  final VoidCallback? onSuspend;
  final VoidCallback? onDeactivate;

  const AdminLawyerCard({
    super.key,
    required this.lawyer,
    this.onViewDetails,
    this.onViewPerformance,
    this.onApprove,
    this.onActivate,
    this.onSuspend,
    this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  child: Text(
                    _initials(lawyer.name),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              lawyer.name,
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (lawyer.isVerified)
                            const Icon(
                              Icons.verified,
                              size: 18,
                            ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        lawyer.specialization,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        lawyer.city,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                AdminLawyerActionMenu(
                  onViewDetails: onViewDetails,
                  onViewPerformance: onViewPerformance,
                  onApprove: lawyer.isApproved
                      ? null
                      : onApprove,
                  onActivate: lawyer.status == 'active'
                      ? null
                      : onActivate,
                  onSuspend: lawyer.status == 'suspended'
                      ? null
                      : onSuspend,
                  onDeactivate: lawyer.status == 'inactive'
                      ? null
                      : onDeactivate,
                ),
              ],
            ),

            const SizedBox(height: 12),

            AdminLawyerStatusChip(
              status: lawyer.status,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.people_outline,
                    label: 'Clients',
                    value: lawyer.totalClients.toString(),
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.folder_outlined,
                    label: 'Active Cases',
                    value: lawyer.activeCases.toString(),
                  ),
                ),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.star_outline,
                    label: 'Rating',
                    value: lawyer.rating.toStringAsFixed(1),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              lawyer.email,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              lawyer.phone,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');

    if (parts.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first.isNotEmpty
          ? parts.first[0].toUpperCase()
          : '?';
    }

    return '${parts.first[0]}${parts.last[0]}'
        .toUpperCase();
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
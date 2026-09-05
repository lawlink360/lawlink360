import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/models/admin_settings_model.dart';

class AdminSettingsCard extends StatelessWidget {
  final AdminSettingsModel settings;
  final VoidCallback? onTap;

  const AdminSettingsCard({
    super.key,
    required this.settings,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: navy.withValues(alpha: 0.08),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.settings_outlined,
                      color: gold,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          settings.appName,
                          style: const TextStyle(
                            color: navy,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Version ${settings.appVersion}',
                          style: TextStyle(
                            color: navy.withValues(alpha: 0.60),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: navy,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _SummaryItem(
                      label: 'Registrations',
                      value: settings.allowNewRegistrations
                          ? 'Open'
                          : 'Closed',
                      icon: Icons.person_add_alt_1_outlined,
                    ),
                  ),
                  Expanded(
                    child: _SummaryItem(
                      label: 'Lawyer Verification',
                      value: settings.requireLawyerVerification
                          ? 'Required'
                          : 'Optional',
                      icon: Icons.verified_user_outlined,
                    ),
                  ),
                  Expanded(
                    child: _SummaryItem(
                      label: 'Payments',
                      value: settings.enablePayments
                          ? 'Enabled'
                          : 'Disabled',
                      icon: Icons.payments_outlined,
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
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: gold,
        ),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: navy,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: navy.withValues(alpha: 0.55),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
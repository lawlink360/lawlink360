import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/providers/admin_settings_provider.dart';
import 'package:lawlink360/core/features/admin_module/admin_settings/widgets/admin_settings_card.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class AdminSettingsScreen extends ConsumerStatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  ConsumerState<AdminSettingsScreen> createState() =>
      _AdminSettingsScreenState();
}

class _AdminSettingsScreenState
    extends ConsumerState<AdminSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminSettingsProvider);

    return Scaffold(
      appBar: AdminAppBar(
        title: 'Admin Settings',
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      drawer: AdminDrawer(
        selectedIndex: 12,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Unable to load settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    ref
                        .read(adminSettingsProvider.notifier)
                        .refresh();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (settings) {
          return RefreshIndicator(
            onRefresh: () {
              return ref
                  .read(adminSettingsProvider.notifier)
                  .refresh();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                AdminSettingsCard(
                  settings: settings,
                  onTap: () {
                    _showGeneralSettings(context, settings);
                  },
                ),
                const SizedBox(height: 8),
                _SettingsSection(
                  title: 'Registration & Verification',
                  icon: Icons.verified_user_outlined,
                  children: [
                    _buildSwitchTile(
                      title: 'Allow New Registrations',
                      subtitle:
                          'Allow new users to create accounts.',
                      value: settings.allowNewRegistrations,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setNewRegistrations(value);
                      },
                    ),
                    _buildSwitchTile(
                      title: 'Allow Lawyer Registrations',
                      subtitle:
                          'Allow lawyers to register on the platform.',
                      value: settings.allowLawyerRegistrations,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setLawyerRegistrations(value);
                      },
                    ),
                    _buildSwitchTile(
                      title: 'Require Lawyer Verification',
                      subtitle:
                          'Require verification before a lawyer can use the platform.',
                      value: settings.requireLawyerVerification,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setLawyerVerification(value);
                      },
                    ),
                    _buildSwitchTile(
                      title: 'Require User Email Verification',
                      subtitle:
                          'Require users to verify their email address.',
                      value: settings.requireUserEmailVerification,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setUserEmailVerification(value);
                      },
                    ),
                  ],
                ),
                _SettingsSection(
                  title: 'Notifications',
                  icon: Icons.notifications_none,
                  children: [
                    _buildSwitchTile(
                      title: 'Notifications',
                      subtitle:
                          'Enable notifications throughout LawLink360.',
                      value: settings.enableNotifications,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setNotifications(value);
                      },
                    ),
                    _buildSwitchTile(
                      title: 'Push Notifications',
                      subtitle:
                          'Enable mobile push notifications.',
                      value: settings.enablePushNotifications,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setPushNotifications(value);
                      },
                    ),
                    _buildSwitchTile(
                      title: 'Email Notifications',
                      subtitle:
                          'Enable email notifications.',
                      value: settings.enableEmailNotifications,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setEmailNotifications(value);
                      },
                    ),
                    _buildSwitchTile(
                      title: 'SMS Notifications',
                      subtitle:
                          'Enable SMS notifications.',
                      value: settings.enableSmsNotifications,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setSmsNotifications(value);
                      },
                    ),
                  ],
                ),
                _SettingsSection(
                  title: 'Payments & Appointments',
                  icon: Icons.payments_outlined,
                  children: [
                    _buildSwitchTile(
                      title: 'Enable Payments',
                      subtitle:
                          'Allow users to make payments through LawLink360.',
                      value: settings.enablePayments,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setPayments(value);
                      },
                    ),
                    _buildValueTile(
                      title: 'Commission Rate',
                      value:
                          '${settings.commissionRate.toStringAsFixed(1)}%',
                      icon: Icons.percent,
                      onTap: () {
                        _editCommissionRate(
                          context,
                          settings.commissionRate,
                        );
                      },
                    ),
                    _buildValueTile(
                      title: 'Cancellation Window',
                      value:
                          '${settings.appointmentCancellationHours} hours',
                      icon: Icons.schedule_outlined,
                      onTap: () {
                        _editCancellationHours(
                          context,
                          settings.appointmentCancellationHours,
                        );
                      },
                    ),
                    _buildValueTile(
                      title: 'Maximum Booking Period',
                      value:
                          '${settings.maxBookingDays} days',
                      icon: Icons.date_range_outlined,
                      onTap: () {
                        _editMaxBookingDays(
                          context,
                          settings.maxBookingDays,
                        );
                      },
                    ),
                  ],
                ),
                _SettingsSection(
                  title: 'Maintenance',
                  icon: Icons.build_outlined,
                  children: [
                    _buildSwitchTile(
                      title: 'Maintenance Mode',
                      subtitle:
                          'Temporarily restrict access to the platform.',
                      value: settings.maintenanceMode,
                      onChanged: (value) {
                        ref
                            .read(adminSettingsProvider.notifier)
                            .setMaintenanceMode(value);
                      },
                    ),
                    _buildValueTile(
                      title: 'Maintenance Message',
                      value: settings.maintenanceMessage.isEmpty
                          ? 'Not configured'
                          : settings.maintenanceMessage,
                      icon: Icons.message_outlined,
                      onTap: () {
                        _editMaintenanceMessage(
                          context,
                          settings.maintenanceMessage,
                        );
                      },
                    ),
                  ],
                ),
                _SettingsSection(
                  title: 'Support',
                  icon: Icons.support_agent_outlined,
                  children: [
                    _buildValueTile(
                      title: 'Support Email',
                      value: settings.supportEmail.isEmpty
                          ? 'Not configured'
                          : settings.supportEmail,
                      icon: Icons.email_outlined,
                      onTap: () {
                        _editTextValue(
                          context: context,
                          title: 'Support Email',
                          initialValue: settings.supportEmail,
                          onSave: (value) {
                            ref
                                .read(adminSettingsProvider.notifier)
                                .updateSupportEmail(value);
                          },
                        );
                      },
                    ),
                    _buildValueTile(
                      title: 'Support Phone',
                      value: settings.supportPhone.isEmpty
                          ? 'Not configured'
                          : settings.supportPhone,
                      icon: Icons.phone_outlined,
                      onTap: () {
                        _editTextValue(
                          context: context,
                          title: 'Support Phone',
                          initialValue: settings.supportPhone,
                          onSave: (value) {
                            ref
                                .read(adminSettingsProvider.notifier)
                                .updateSupportPhone(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      activeThumbColor: gold,
      activeTrackColor: gold.withValues(alpha: 0.35),
      title: Text(
        title,
        style: const TextStyle(
          color: navy,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: navy.withValues(alpha: 0.60),
          fontSize: 12,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
    );
  }

  Widget _buildValueTile({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: gold.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: gold,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: navy,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        value,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: navy.withValues(alpha: 0.58),
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: navy,
      ),
    );
  }

  void _showGeneralSettings(
    BuildContext context,
    dynamic settings,
  ) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Application Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${settings.appName} • Version ${settings.appVersion}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 18),
                const ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: Text('Privacy Policy'),
                  subtitle: Text('Configured'),
                ),
                const ListTile(
                  leading: Icon(Icons.description_outlined),
                  title: Text('Terms & Conditions'),
                  subtitle: Text('Configured'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _editCommissionRate(
    BuildContext context,
    double currentValue,
  ) {
    final controller = TextEditingController(
      text: currentValue.toString(),
    );

    _showEditDialog(
      context,
      title: 'Commission Rate',
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      onSave: () {
        final value = double.tryParse(controller.text.trim());

        if (value == null || value < 0 || value > 100) {
          return false;
        }

        ref
            .read(adminSettingsProvider.notifier)
            .updateCommissionRate(value);

        return true;
      },
    );
  }

  void _editCancellationHours(
    BuildContext context,
    int currentValue,
  ) {
    final controller = TextEditingController(
      text: currentValue.toString(),
    );

    _showEditDialog(
      context,
      title: 'Cancellation Window',
      controller: controller,
      keyboardType: TextInputType.number,
      onSave: () {
        final value = int.tryParse(controller.text.trim());

        if (value == null || value < 0) {
          return false;
        }

        ref
            .read(adminSettingsProvider.notifier)
            .updateAppointmentCancellationHours(value);

        return true;
      },
    );
  }

  void _editMaxBookingDays(
    BuildContext context,
    int currentValue,
  ) {
    final controller = TextEditingController(
      text: currentValue.toString(),
    );

    _showEditDialog(
      context,
      title: 'Maximum Booking Period',
      controller: controller,
      keyboardType: TextInputType.number,
      onSave: () {
        final value = int.tryParse(controller.text.trim());

        if (value == null || value <= 0) {
          return false;
        }

        ref
            .read(adminSettingsProvider.notifier)
            .updateMaxBookingDays(value);

        return true;
      },
    );
  }

  void _editMaintenanceMessage(
    BuildContext context,
    String currentValue,
  ) {
    _editTextValue(
      context: context,
      title: 'Maintenance Message',
      initialValue: currentValue,
      onSave: (value) {
        ref
            .read(adminSettingsProvider.notifier)
            .updateMaintenanceMessage(value);
      },
    );
  }

  void _editTextValue({
    required BuildContext context,
    required String title,
    required String initialValue,
    required ValueChanged<String> onSave,
  }) {
    final controller = TextEditingController(
      text: initialValue,
    );

    _showEditDialog(
      context,
      title: title,
      controller: controller,
      onSave: () {
        onSave(controller.text.trim());
        return true;
      },
    );
  }

  void _showEditDialog(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required bool Function() onSave,
    TextInputType? keyboardType,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: title == 'Maintenance Message' ? 3 : 1,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter $title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (onSave()) {
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: navy.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: gold,
                  size: 21,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}
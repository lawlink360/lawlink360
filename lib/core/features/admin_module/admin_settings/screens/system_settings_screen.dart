import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_settings/providers/admin_settings_provider.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_app_bar.dart';
import 'package:lawlink360/core/features/admin_module/widgets/admin_drawer.dart';

class SystemSettingsScreen extends ConsumerStatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  ConsumerState<SystemSettingsScreen> createState() =>
      _SystemSettingsScreenState();
}

class _SystemSettingsScreenState extends ConsumerState<SystemSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(systemSettingsProvider);

    return Scaffold(
      appBar: AdminAppBar(
        title: 'System Settings',
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
        loading: () => const Center(child: CircularProgressIndicator()),
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
                  'Unable to load system settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(error.toString(), textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(systemSettingsProvider.notifier).refresh();
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
              return ref.read(systemSettingsProvider.notifier).refresh();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _Section(
                  title: 'System Status',
                  icon: Icons.monitor_heart_outlined,
                  children: [
                    _switchTile(
                      title: 'Maintenance Mode',
                      subtitle: 'Temporarily restrict access to the platform.',
                      value: settings.maintenanceMode,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setMaintenanceMode(value);
                      },
                    ),
                    _switchTile(
                      title: 'Debug Mode',
                      subtitle: 'Enable additional diagnostic information.',
                      value: settings.debugMode,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setDebugMode(value);
                      },
                    ),
                    _valueTile(
                      title: 'Maintenance Message',
                      value: settings.maintenanceMessage.isEmpty
                          ? 'Not configured'
                          : settings.maintenanceMessage,
                      icon: Icons.message_outlined,
                      onTap: () {
                        _editText(
                          context,
                          title: 'Maintenance Message',
                          initialValue: settings.maintenanceMessage,
                          maxLines: 3,
                          onSave: (value) {
                            // The system model currently exposes the
                            // message through copyWith. This update
                            // will be wired to persistence in the
                            // service/Firebase phase.
                            final current = ref
                                .read(systemSettingsProvider)
                                .value;

                            if (current != null) {
                              ref
                                  .read(systemSettingsProvider.notifier)
                                  .updateSettings(
                                    current.copyWith(
                                      maintenanceMessage: value,
                                      updatedAt: DateTime.now(),
                                    ),
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                _Section(
                  title: 'Security',
                  icon: Icons.security_outlined,
                  children: [
                    _switchTile(
                      title: 'Two-Factor Authentication',
                      subtitle:
                          'Require an additional authentication factor for administrators.',
                      value: settings.enableTwoFactorAuthentication,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setTwoFactorAuthentication(value);
                      },
                    ),
                    _switchTile(
                      title: 'Strong Passwords',
                      subtitle: 'Enforce strong password requirements.',
                      value: settings.enforceStrongPasswords,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setStrongPasswords(value);
                      },
                    ),
                    _valueTile(
                      title: 'Session Timeout',
                      value: '${settings.sessionTimeoutMinutes} minutes',
                      icon: Icons.timer_outlined,
                      onTap: () {
                        _editInteger(
                          context,
                          title: 'Session Timeout',
                          initialValue: settings.sessionTimeoutMinutes,
                          onSave: (value) {
                            ref
                                .read(systemSettingsProvider.notifier)
                                .updateSessionTimeout(value);
                          },
                        );
                      },
                    ),
                    _valueTile(
                      title: 'Maximum Login Attempts',
                      value: '${settings.maxLoginAttempts} attempts',
                      icon: Icons.login_outlined,
                      onTap: () {
                        _editInteger(
                          context,
                          title: 'Maximum Login Attempts',
                          initialValue: settings.maxLoginAttempts,
                          onSave: (value) {
                            ref
                                .read(systemSettingsProvider.notifier)
                                .updateMaxLoginAttempts(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
                _Section(
                  title: 'Platform Features',
                  icon: Icons.apps_outlined,
                  children: [
                    _switchTile(
                      title: 'Appointments',
                      subtitle: 'Enable appointment booking and management.',
                      value: settings.enableAppointments,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setAppointments(value);
                      },
                    ),
                    _switchTile(
                      title: 'Cases',
                      subtitle: 'Enable case management features.',
                      value: settings.enableCases,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setCases(value);
                      },
                    ),
                    _switchTile(
                      title: 'Chat',
                      subtitle: 'Enable in-app user and lawyer chat.',
                      value: settings.enableChat,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setChat(value);
                      },
                    ),
                    _switchTile(
                      title: 'Voice Calls',
                      subtitle: 'Enable voice consultation features.',
                      value: settings.enableVoiceCalls,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setVoiceCalls(value);
                      },
                    ),
                    _switchTile(
                      title: 'Video Calls',
                      subtitle: 'Enable video consultation features.',
                      value: settings.enableVideoCalls,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setVideoCalls(value);
                      },
                    ),
                    _switchTile(
                      title: 'Payments',
                      subtitle: 'Enable payment processing.',
                      value: settings.enablePayments,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setPayments(value);
                      },
                    ),
                    _switchTile(
                      title: 'Document Uploads',
                      subtitle: 'Allow users to upload documents.',
                      value: settings.enableDocumentUploads,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setDocumentUploads(value);
                      },
                    ),
                  ],
                ),
                _Section(
                  title: 'Notifications',
                  icon: Icons.notifications_none,
                  children: [
                    _switchTile(
                      title: 'Push Notifications',
                      subtitle: 'Enable push notifications.',
                      value: settings.enablePushNotifications,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setPushNotifications(value);
                      },
                    ),
                    _switchTile(
                      title: 'Email Notifications',
                      subtitle: 'Enable email notifications.',
                      value: settings.enableEmailNotifications,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setEmailNotifications(value);
                      },
                    ),
                    _switchTile(
                      title: 'SMS Notifications',
                      subtitle: 'Enable SMS notifications.',
                      value: settings.enableSmsNotifications,
                      onChanged: (value) {
                        ref
                            .read(systemSettingsProvider.notifier)
                            .setSmsNotifications(value);
                      },
                    ),
                  ],
                ),
                _Section(
                  title: 'Storage',
                  icon: Icons.storage_outlined,
                  children: [
                    _valueTile(
                      title: 'Maximum File Size',
                      value: '${settings.maxFileSizeMb} MB',
                      icon: Icons.file_upload_outlined,
                      onTap: () {
                        _editInteger(
                          context,
                          title: 'Maximum File Size',
                          initialValue: settings.maxFileSizeMb,
                          onSave: (value) {
                            ref
                                .read(systemSettingsProvider.notifier)
                                .updateMaxFileSize(value);
                          },
                        );
                      },
                    ),
                    _valueTile(
                      title: 'Documents Per User',
                      value: '${settings.maxDocumentsPerUser} documents',
                      icon: Icons.folder_copy_outlined,
                      onTap: () {
                        _editInteger(
                          context,
                          title: 'Documents Per User',
                          initialValue: settings.maxDocumentsPerUser,
                          onSave: (value) {
                            ref
                                .read(systemSettingsProvider.notifier)
                                .updateMaxDocumentsPerUser(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
                _Section(
                  title: 'Environment & Localization',
                  icon: Icons.language_outlined,
                  children: [
                    _valueTile(
                      title: 'API Environment',
                      value: settings.apiEnvironment,
                      icon: Icons.api_outlined,
                      onTap: () {
                        _selectEnvironment(context, settings.apiEnvironment);
                      },
                    ),
                    _valueTile(
                      title: 'Default Language',
                      value: settings.defaultLanguage,
                      icon: Icons.translate_outlined,
                      onTap: () {
                        _selectLanguage(context, settings.defaultLanguage);
                      },
                    ),
                    _valueTile(
                      title: 'Default Country',
                      value: settings.defaultCountry,
                      icon: Icons.public_outlined,
                      onTap: () {
                        _showInfo(context, 'Default Country', 'Pakistan');
                      },
                    ),
                    _valueTile(
                      title: 'Timezone',
                      value: settings.timezone,
                      icon: Icons.schedule_outlined,
                      onTap: () {
                        _selectTimezone(context, settings.timezone);
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

  Widget _switchTile({
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
        style: const TextStyle(color: navy, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: navy.withValues(alpha: 0.60), fontSize: 12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _valueTile({
    required String title,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    const navy = Color(0xFF17233C);
    const gold = Color(0xFFC9A227);

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: gold.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: gold, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(color: navy, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        value,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: navy.withValues(alpha: 0.58), fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: navy),
    );
  }

  void _editInteger(
    BuildContext context, {
    required String title,
    required int initialValue,
    required ValueChanged<int> onSave,
  }) {
    final controller = TextEditingController(text: initialValue.toString());

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder()),
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
                final value = int.tryParse(controller.text.trim());

                if (value == null || value <= 0) {
                  return;
                }

                onSave(value);
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editText(
    BuildContext context, {
    required String title,
    required String initialValue,
    required int maxLines,
    required ValueChanged<String> onSave,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: const InputDecoration(border: OutlineInputBorder()),
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
                onSave(controller.text.trim());
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _selectEnvironment(BuildContext context, String current) {
    _showSelection(
      context,
      title: 'API Environment',
      currentValue: current,
      options: const ['development', 'staging', 'production'],
      onSelected: (value) {
        ref.read(systemSettingsProvider.notifier).updateApiEnvironment(value);
      },
    );
  }

  void _selectLanguage(BuildContext context, String current) {
    _showSelection(
      context,
      title: 'Default Language',
      currentValue: current,
      options: const ['English', 'Urdu'],
      onSelected: (value) {
        ref.read(systemSettingsProvider.notifier).updateDefaultLanguage(value);
      },
    );
  }

  void _selectTimezone(BuildContext context, String current) {
    _showSelection(
      context,
      title: 'Timezone',
      currentValue: current,
      options: const ['Asia/Karachi', 'UTC', 'Asia/Dubai'],
      onSelected: (value) {
        ref.read(systemSettingsProvider.notifier).updateTimezone(value);
      },
    );
  }

  void _showSelection(
    BuildContext context, {
    required String title,
    required String currentValue,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              RadioGroup<String>(
                groupValue: currentValue,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  onSelected(value);
                  Navigator.pop(sheetContext);
                },
                child: Column(
                  children: [
                    ...options.map(
                      (option) => RadioListTile<String>(
                        value: option,
                        title: Text(option),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInfo(BuildContext context, String title, String message) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _Section({
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
        border: Border.all(color: navy.withValues(alpha: 0.08)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                Icon(icon, color: gold, size: 21),
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

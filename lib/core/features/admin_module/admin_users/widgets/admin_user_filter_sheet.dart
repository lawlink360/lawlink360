import 'package:flutter/material.dart';

class AdminUserFilterSheet extends StatelessWidget {
  final String? selectedStatus;
  final ValueChanged<String?> onStatusChanged;
  final VoidCallback onClear;

  const AdminUserFilterSheet({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.onClear,
  });

  static Future<void> show({
    required BuildContext context,
    required String? selectedStatus,
    required ValueChanged<String?> onStatusChanged,
    required VoidCallback onClear,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return AdminUserFilterSheet(
          selectedStatus: selectedStatus,
          onStatusChanged: onStatusChanged,
          onClear: onClear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Users',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Divider(),

              const SizedBox(height: 8),

              const Text(
                'Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              RadioGroup<String?>(
                groupValue: selectedStatus,
                onChanged: onStatusChanged,
                child: Column(
                  children: [
                    RadioListTile<String?>(
                      value: null,
                      title: const Text('All Users'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'active',
                      title: const Text('Active'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'inactive',
                      title: const Text('Inactive'),
                      contentPadding: EdgeInsets.zero,
                    ),

                    RadioListTile<String?>(
                      value: 'suspended',
                      title: const Text('Suspended'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onClear,
                  child: const Text('Clear Filters'),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

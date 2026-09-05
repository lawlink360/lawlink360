import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_status_model.dart';

class VerificationFilterSheet extends StatelessWidget {
  final String? selectedStatus;
  final ValueChanged<String?> onStatusChanged;
  final VoidCallback onClear;

  const VerificationFilterSheet({
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
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) {
        return VerificationFilterSheet(
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Verifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Verification Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RadioGroup<String>(
              groupValue: selectedStatus,
              onChanged: onStatusChanged,
              child: Column(
                children: VerificationStatusModel.all.map((status) {
                  return RadioListTile<String>(
                    value: status.value,
                    title: Text(status.label),
                    contentPadding: EdgeInsets.zero,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onClear,
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
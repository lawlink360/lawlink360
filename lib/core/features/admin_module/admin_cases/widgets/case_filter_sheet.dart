import 'package:flutter/material.dart';

import '../models/case_status_model.dart';

class CaseFilterSheet extends StatefulWidget {
  final String? selectedStatus;
  final String? selectedCaseType;

  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onCaseTypeChanged;
  final VoidCallback onClear;

  const CaseFilterSheet({
    super.key,
    required this.selectedStatus,
    required this.selectedCaseType,
    required this.onStatusChanged,
    required this.onCaseTypeChanged,
    required this.onClear,
  });

  static Future<void> show({
    required BuildContext context,
    required String? selectedStatus,
    required String? selectedCaseType,
    required ValueChanged<String?> onStatusChanged,
    required ValueChanged<String?> onCaseTypeChanged,
    required VoidCallback onClear,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => CaseFilterSheet(
        selectedStatus: selectedStatus,
        selectedCaseType: selectedCaseType,
        onStatusChanged: onStatusChanged,
        onCaseTypeChanged: onCaseTypeChanged,
        onClear: onClear,
      ),
    );
  }

  @override
  State<CaseFilterSheet> createState() => _CaseFilterSheetState();
}

class _CaseFilterSheetState extends State<CaseFilterSheet> {
  late String? _status;
  late String? _caseType;

  static const List<String> _caseTypes = [
    'Civil',
    'Criminal',
    'Family',
    'Property',
    'Labour',
    'Corporate',
  ];

  @override
  void initState() {
    super.initState();
    _status = widget.selectedStatus;
    _caseType = widget.selectedCaseType;
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
              'Filter Cases',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Case Status',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: _status,
              onChanged: (value) {
                setState(() {
                  _status = value;
                });
              },
              child: Column(
                children: [
                  RadioListTile<String?>(
                    value: null,
                    title: const Text('All'),
                  ),
                  ...CaseStatusModel.values.map(
                    (status) => RadioListTile<String?>(
                      value: status,
                      title: Text(status),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Case Type',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: _caseType,
              onChanged: (value) {
                setState(() {
                  _caseType = value;
                });
              },
              child: Column(
                children: [
                  RadioListTile<String?>(
                    value: null,
                    title: const Text('All'),
                  ),
                  ..._caseTypes.map(
                    (type) => RadioListTile<String?>(
                      value: type,
                      title: Text(type),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onClear();
                      Navigator.pop(context);
                    },
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      widget.onStatusChanged(_status);
                      widget.onCaseTypeChanged(_caseType);
                      Navigator.pop(context);
                    },
                    child: const Text('Apply Filters'),
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
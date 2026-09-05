import 'package:flutter/material.dart';

class ReportFilterSheet extends StatefulWidget {
  final String selectedStatus;
  final String selectedPriority;
  final String selectedType;
  final List<String> reportTypes;
  final ValueChanged<String>? onStatusChanged;
  final ValueChanged<String>? onPriorityChanged;
  final ValueChanged<String>? onTypeChanged;
  final VoidCallback? onClear;
  final VoidCallback? onApply;

  const ReportFilterSheet({
    super.key,
    this.selectedStatus = 'All',
    this.selectedPriority = 'All',
    this.selectedType = 'All',
    this.reportTypes = const [],
    this.onStatusChanged,
    this.onPriorityChanged,
    this.onTypeChanged,
    this.onClear,
    this.onApply,
  });

  static Future<void> show({
    required BuildContext context,
    String selectedStatus = 'All',
    String selectedPriority = 'All',
    String selectedType = 'All',
    List<String> reportTypes = const [],
    ValueChanged<String>? onStatusChanged,
    ValueChanged<String>? onPriorityChanged,
    ValueChanged<String>? onTypeChanged,
    VoidCallback? onClear,
    VoidCallback? onApply,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return ReportFilterSheet(
          selectedStatus: selectedStatus,
          selectedPriority: selectedPriority,
          selectedType: selectedType,
          reportTypes: reportTypes,
          onStatusChanged: onStatusChanged,
          onPriorityChanged: onPriorityChanged,
          onTypeChanged: onTypeChanged,
          onClear: onClear,
          onApply: onApply,
        );
      },
    );
  }

  @override
  State<ReportFilterSheet> createState() =>
      _ReportFilterSheetState();
}

class _ReportFilterSheetState
    extends State<ReportFilterSheet> {
  late String _status;
  late String _priority;
  late String _type;

  final List<String> _statuses = const [
    'All',
    'Pending',
    'Under Review',
    'Investigating',
    'Resolved',
    'Rejected',
    'Closed',
  ];

  final List<String> _priorities = const [
    'All',
    'Low',
    'Medium',
    'High',
    'Critical',
    'Urgent',
  ];

  @override
  void initState() {
    super.initState();

    _status = widget.selectedStatus;
    _priority = widget.selectedPriority;
    _type = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom;

    final types = [
      'All',
      ...widget.reportTypes.where(
        (type) => type != 'All',
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomInset,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Filter Reports',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF17233C),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                _FilterSection(
                  title: 'Status',
                  child: _FilterWrap(
                    options: _statuses,
                    selected: _status,
                    onSelected: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                _FilterSection(
                  title: 'Priority',
                  child: _FilterWrap(
                    options: _priorities,
                    selected: _priority,
                    onSelected: (value) {
                      setState(() {
                        _priority = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                _FilterSection(
                  title: 'Report Type',
                  child: _FilterWrap(
                    options: types,
                    selected: _type,
                    onSelected: (value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _status = 'All';
                            _priority = 'All';
                            _type = 'All';
                          });

                          widget.onClear?.call();
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                              const Size.fromHeight(48),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Clear',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onStatusChanged
                              ?.call(_status);
                          widget.onPriorityChanged
                              ?.call(_priority);
                          widget.onTypeChanged
                              ?.call(_type);
                          widget.onApply?.call();

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              const Size.fromHeight(48),
                          backgroundColor:
                              const Color(0xFFC9A227),
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF17233C),
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _FilterWrap extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  const _FilterWrap({
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final bool isSelected =
            option == selected;

        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => onSelected(option),
          selectedColor: const Color(0xFFC9A227)
              .withValues(alpha: 0.15),
          backgroundColor:
              Colors.grey.withValues(alpha: 0.06),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFFC9A227)
                : Colors.grey.withValues(alpha: 0.15),
          ),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: isSelected
                ? FontWeight.w700
                : FontWeight.w500,
            color: isSelected
                ? const Color(0xFF9A7715)
                : Colors.grey.shade700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }).toList(),
    );
  }
}
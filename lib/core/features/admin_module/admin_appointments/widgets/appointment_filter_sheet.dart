import 'package:flutter/material.dart';

import 'package:lawlink360/core/features/admin_module/admin_appointments/models/appointment_status_model.dart';

class AppointmentFilterSheet extends StatefulWidget {
  final String? selectedStatus;
  final String? selectedAppointmentType;
  final String? selectedPaymentStatus;

  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onAppointmentTypeChanged;
  final ValueChanged<String?> onPaymentStatusChanged;
  final VoidCallback onClear;

  const AppointmentFilterSheet({
    super.key,
    this.selectedStatus,
    this.selectedAppointmentType,
    this.selectedPaymentStatus,
    required this.onStatusChanged,
    required this.onAppointmentTypeChanged,
    required this.onPaymentStatusChanged,
    required this.onClear,
  });

  static Future<void> show({
    required BuildContext context,
    required String? selectedStatus,
    required String? selectedAppointmentType,
    required String? selectedPaymentStatus,
    required ValueChanged<String?> onStatusChanged,
    required ValueChanged<String?> onAppointmentTypeChanged,
    required ValueChanged<String?> onPaymentStatusChanged,
    required VoidCallback onClear,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) {
        return AppointmentFilterSheet(
          selectedStatus: selectedStatus,
          selectedAppointmentType: selectedAppointmentType,
          selectedPaymentStatus: selectedPaymentStatus,
          onStatusChanged: onStatusChanged,
          onAppointmentTypeChanged: onAppointmentTypeChanged,
          onPaymentStatusChanged: onPaymentStatusChanged,
          onClear: onClear,
        );
      },
    );
  }

  @override
  State<AppointmentFilterSheet> createState() =>
      _AppointmentFilterSheetState();
}

class _AppointmentFilterSheetState extends State<AppointmentFilterSheet> {
  late String? _status;
  late String? _appointmentType;
  late String? _paymentStatus;

  static const List<String> _appointmentTypes = [
    'Video Consultation',
    'Phone Consultation',
    'In-Person Consultation',
  ];

  static const List<String> _paymentStatuses = [
    'Paid',
    'Pending',
    'Refunded',
  ];

  @override
  void initState() {
    super.initState();

    _status = widget.selectedStatus;
    _appointmentType = widget.selectedAppointmentType;
    _paymentStatus = widget.selectedPaymentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Appointment Filters',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _status = null;
                      _appointmentType = null;
                      _paymentStatus = null;
                    });

                    widget.onClear();
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SectionTitle(
              title: 'Status',
              icon: Icons.event_available_outlined,
            ),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: _status,
              onChanged: (value) {
                setState(() {
                  _status = value;
                });

                widget.onStatusChanged(value);
              },
              child: Column(
                children: [
                  const RadioListTile<String?>(
                    value: null,
                    title: Text('All Statuses'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ...AppointmentStatusModel.all.map(
                    (status) => RadioListTile<String?>(
                      value: status.value,
                      title: Text(status.label),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionTitle(
              title: 'Appointment Type',
              icon: Icons.video_call_outlined,
            ),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: _appointmentType,
              onChanged: (value) {
                setState(() {
                  _appointmentType = value;
                });

                widget.onAppointmentTypeChanged(value);
              },
              child: Column(
                children: [
                  const RadioListTile<String?>(
                    value: null,
                    title: Text('All Types'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ..._appointmentTypes.map(
                    (type) => RadioListTile<String?>(
                      value: type,
                      title: Text(type),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionTitle(
              title: 'Payment Status',
              icon: Icons.payments_outlined,
            ),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: _paymentStatus,
              onChanged: (value) {
                setState(() {
                  _paymentStatus = value;
                });

                widget.onPaymentStatusChanged(value);
              },
              child: Column(
                children: [
                  const RadioListTile<String?>(
                    value: null,
                    title: Text('All Payment Statuses'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  ..._paymentStatuses.map(
                    (status) => RadioListTile<String?>(
                      value: status,
                      title: Text(status),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 19,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
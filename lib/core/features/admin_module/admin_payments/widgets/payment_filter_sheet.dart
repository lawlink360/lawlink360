import 'package:flutter/material.dart';

class PaymentFilterSheet extends StatefulWidget {
  final String? selectedStatus;
  final String? selectedPaymentMethod;
  final String? selectedPaymentGateway;

  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onPaymentMethodChanged;
  final ValueChanged<String?> onPaymentGatewayChanged;
  final VoidCallback onClear;

  const PaymentFilterSheet({
    super.key,
    this.selectedStatus,
    this.selectedPaymentMethod,
    this.selectedPaymentGateway,
    required this.onStatusChanged,
    required this.onPaymentMethodChanged,
    required this.onPaymentGatewayChanged,
    required this.onClear,
  });

  static Future<void> show({
    required BuildContext context,
    required String? selectedStatus,
    required String? selectedPaymentMethod,
    required String? selectedPaymentGateway,
    required ValueChanged<String?> onStatusChanged,
    required ValueChanged<String?> onPaymentMethodChanged,
    required ValueChanged<String?> onPaymentGatewayChanged,
    required VoidCallback onClear,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return PaymentFilterSheet(
          selectedStatus: selectedStatus,
          selectedPaymentMethod: selectedPaymentMethod,
          selectedPaymentGateway: selectedPaymentGateway,
          onStatusChanged: onStatusChanged,
          onPaymentMethodChanged: onPaymentMethodChanged,
          onPaymentGatewayChanged: onPaymentGatewayChanged,
          onClear: onClear,
        );
      },
    );
  }

  @override
  State<PaymentFilterSheet> createState() =>
      _PaymentFilterSheetState();
}

class _PaymentFilterSheetState extends State<PaymentFilterSheet> {
  String? _status;
  String? _paymentMethod;
  String? _paymentGateway;

  final List<String> _statuses = [
    'Completed',
    'Pending',
    'Refunded',
    'Failed',
  ];

  final List<String> _paymentMethods = [
    'Card',
    'JazzCash',
    'EasyPaisa',
    'Bank Transfer',
  ];

  final List<String> _paymentGateways = [
    'Stripe',
    'JazzCash',
    'EasyPaisa',
    'Bank',
  ];

  @override
  void initState() {
    super.initState();
    _status = widget.selectedStatus;
    _paymentMethod = widget.selectedPaymentMethod;
    _paymentGateway = widget.selectedPaymentGateway;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Payment Filters',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onClear();
                      Navigator.pop(context);
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Status',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              RadioGroup<String?>(
                groupValue: _status,
                onChanged: (value) {
                  setState(() => _status = value);
                },
                child: Column(
                  children: [
                    const RadioListTile<String?>(
                      value: null,
                      title: Text('All'),
                    ),
                    ..._statuses.map(
                      (status) => RadioListTile<String?>(
                        value: status,
                        title: Text(status),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              RadioGroup<String?>(
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() => _paymentMethod = value);
                },
                child: Column(
                  children: [
                    const RadioListTile<String?>(
                      value: null,
                      title: Text('All'),
                    ),
                    ..._paymentMethods.map(
                      (method) => RadioListTile<String?>(
                        value: method,
                        title: Text(method),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const Text(
                'Payment Gateway',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              RadioGroup<String?>(
                groupValue: _paymentGateway,
                onChanged: (value) {
                  setState(() => _paymentGateway = value);
                },
                child: Column(
                  children: [
                    const RadioListTile<String?>(
                      value: null,
                      title: Text('All'),
                    ),
                    ..._paymentGateways.map(
                      (gateway) => RadioListTile<String?>(
                        value: gateway,
                        title: Text(gateway),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    widget.onStatusChanged(_status);
                    widget.onPaymentMethodChanged(_paymentMethod);
                    widget.onPaymentGatewayChanged(_paymentGateway);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/fee_model.dart';
import '../providers/clerk_providers.dart';


class RecordPaymentScreen extends ConsumerStatefulWidget {
  const RecordPaymentScreen({
    super.key,
    required this.fee,
  });

  final FeeModel fee;

  @override
  ConsumerState<RecordPaymentScreen> createState() =>
      _RecordPaymentScreenState();
}

class _RecordPaymentScreenState
    extends ConsumerState<RecordPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _paymentDate = DateTime.now();

  String _paymentMethod = 'Cash';

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectPaymentDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _paymentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _paymentDate = selectedDate;
    });
  }

  void _recordPayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(
      _amountController.text.trim(),
    );

    if (amount == null || amount <= 0) {
      return;
    }

    final remaining = widget.fee.remainingAmount;

    if (amount > remaining) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Payment cannot be greater than the pending amount.',
          ),
        ),
      );
      return;
    }

    ref.read(clerkFeesProvider.notifier).recordPayment(
          feeId: widget.fee.id,
          amount: amount,
          paymentDate: _paymentDate,
          paymentMethod: _paymentMethod,
          referenceNumber:
              _referenceController.text.trim().isEmpty
                  ? null
                  : _referenceController.text.trim(),
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Payment recorded successfully.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final fee = widget.fee;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Record Payment',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            30,
          ),
          children: [
            // ==================================================
            // CLIENT INFORMATION
            // ==================================================

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Client',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    fee.clientName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF13294B),
                    ),
                  ),

                  if (fee.caseTitle != null &&
                      fee.caseTitle!.trim().isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      fee.caseTitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _AmountSummary(
                          label: 'Total Fee',
                          amount: fee.totalFee,
                        ),
                      ),
                      Expanded(
                        child: _AmountSummary(
                          label: 'Received',
                          amount: fee.paidAmount,
                        ),
                      ),
                      Expanded(
                        child: _AmountSummary(
                          label: 'Pending',
                          amount: fee.remainingAmount,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // PAYMENT AMOUNT
            // ==================================================

            const Text(
              'Payment Amount',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _inputDecoration(
                label: 'Amount',
                hint: 'Enter payment amount',
                prefix: 'Rs. ',
                icon: Icons.payments_outlined,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter payment amount';
                }

                final amount =
                    double.tryParse(value.trim());

                if (amount == null || amount <= 0) {
                  return 'Enter a valid amount';
                }

                if (amount > fee.remainingAmount) {
                  return 'Amount exceeds pending fee';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PAYMENT DATE
            // ==================================================

            const Text(
              'Payment Date',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 8),

            InkWell(
              onTap: _selectPaymentDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: _inputDecoration(
                  label: 'Date',
                  hint: '',
                  icon: Icons.calendar_today_outlined,
                ),
                child: Text(
                  _formatDate(_paymentDate),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // PAYMENT METHOD
            // ==================================================

            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: _inputDecoration(
                label: 'Method',
                hint: '',
                icon: Icons.account_balance_wallet_outlined,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Cash',
                  child: Text('Cash'),
                ),
                DropdownMenuItem(
                  value: 'Bank Transfer',
                  child: Text('Bank Transfer'),
                ),
                DropdownMenuItem(
                  value: 'Cheque',
                  child: Text('Cheque'),
                ),
                DropdownMenuItem(
                  value: 'Online Payment',
                  child: Text('Online Payment'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _paymentMethod = value;
                });
              },
            ),

            const SizedBox(height: 16),

            // ==================================================
            // REFERENCE NUMBER
            // ==================================================

            TextFormField(
              controller: _referenceController,
              decoration: _inputDecoration(
                label: 'Reference Number',
                hint: 'Optional',
                icon: Icons.tag_outlined,
              ),
            ),

            const SizedBox(height: 16),

            // ==================================================
            // NOTES
            // ==================================================

            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: _inputDecoration(
                label: 'Notes',
                hint: 'Optional payment notes',
                icon: Icons.notes_outlined,
              ),
            ),

            const SizedBox(height: 24),

            // ==================================================
            // SAVE
            // ==================================================

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _recordPayment,
                icon: const Icon(
                  Icons.check_circle_outline,
                ),
                label: const Text(
                  'Record Payment',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13294B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    String? prefix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixText: prefix,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF13294B),
        size: 20,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF13294B),
          width: 1.3,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

// ======================================================
// AMOUNT SUMMARY
// ======================================================

class _AmountSummary extends StatelessWidget {
  const _AmountSummary({
    required this.label,
    required this.amount,
  });

  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Rs. ${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF13294B),
          ),
        ),
      ],
    );
  }
}
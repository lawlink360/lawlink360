import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/clerk_providers.dart';
import '../models/fee_model.dart';
import 'package:lawlink360/core/features/lawyer_module/digital_clerk/screens/record_payment_screen.dart';


class PaymentRecordsScreen extends ConsumerWidget {
  const PaymentRecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(clerkFeesProvider);

    final totalReceived = fees.fold<double>(
      0,
      (sum, fee) => sum + fee.paidAmount,
    );

    final totalPending = fees.fold<double>(
      0,
      (sum, fee) => sum + fee.remainingAmount,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Payment Records',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        children: [
          // ======================================================
          // SUMMARY
          // ======================================================

          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Received',
                  amount: _formatCurrency(totalReceived),
                  icon: Icons.arrow_downward_rounded,
                  iconColor: Colors.green,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _SummaryCard(
                  title: 'Pending',
                  amount: _formatCurrency(totalPending),
                  icon: Icons.access_time_rounded,
                  iconColor: Colors.orange,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ======================================================
          // HEADER
          // ======================================================

          const Text(
            'Client Payment Records',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'View received and pending payments for your clients.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 14),

          // ======================================================
          // RECORDS
          // ======================================================

          if (fees.isEmpty)
            const _EmptyPaymentState()
          else
            ...fees.map(
              (fee) => _PaymentRecordCard(
                fee: fee,
              ),
            ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    return 'Rs. ${amount.toStringAsFixed(0)}';
  }
}

// ======================================================
// SUMMARY CARD
// ======================================================

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String amount;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
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
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            amount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// PAYMENT RECORD CARD
// ======================================================

class _PaymentRecordCard extends StatelessWidget {
  const _PaymentRecordCard({
    required this.fee,
  });

  final FeeModel fee;

  @override
  Widget build(BuildContext context) {
    final isPaid =
        fee.paymentStatus.trim().toLowerCase() == 'paid';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
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
          // ====================================================
          // CLIENT + STATUS
          // ====================================================

          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF13294B)
                      .withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF13294B),
                  size: 21,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fee.clientName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13294B),
                      ),
                    ),

                    if (fee.caseTitle != null &&
                        fee.caseTitle!.trim().isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        fee.caseTitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),

              _StatusBadge(
                status: fee.paymentStatus,
                isPaid: isPaid,
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Divider(height: 1),

          const SizedBox(height: 14),

          // ====================================================
          // AMOUNTS
          // ====================================================

          Row(
            children: [
              Expanded(
                child: _AmountItem(
                  label: 'Total',
                  amount: fee.totalFee,
                ),
              ),
              Expanded(
                child: _AmountItem(
                  label: 'Received',
                  amount: fee.paidAmount,
                ),
              ),
              Expanded(
                child: _AmountItem(
                  label: 'Pending',
                  amount: fee.remainingAmount,
                ),
              ),
            ],
          ),

          // ====================================================
          // DUE DATE
          // ====================================================

          if (fee.dueDate != null) ...[
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Color(0xFF13294B),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    'Due ${_formatDate(fee.dueDate!)}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ====================================================
          // RECORD PAYMENT BUTTON
          // ====================================================

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => RecordPaymentScreen(
        fee: fee,
      ),
    ),
  );
},
              icon: const Icon(
                Icons.add_card_rounded,
                size: 18,
              ),
              label: const Text(
                'Record Payment',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13294B),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
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
// AMOUNT ITEM
// ======================================================

class _AmountItem extends StatelessWidget {
  const _AmountItem({
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
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF13294B),
          ),
        ),
      ],
    );
  }
}

// ======================================================
// STATUS BADGE
// ======================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
    required this.isPaid,
  });

  final String status;
  final bool isPaid;

  @override
  Widget build(BuildContext context) {
    final color = isPaid
        ? Colors.green
        : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

// ======================================================
// EMPTY STATE
// ======================================================

class _EmptyPaymentState extends StatelessWidget {
  const _EmptyPaymentState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.payments_outlined,
            size: 42,
            color: Colors.grey,
          ),

          SizedBox(height: 10),

          Text(
            'No Payment Records',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF13294B),
            ),
          ),

          SizedBox(height: 5),

          Text(
            'Payment records will appear here when fee records are added.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
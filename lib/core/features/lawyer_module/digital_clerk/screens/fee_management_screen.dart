import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/clerk_providers.dart';
import 'fee_structure_screen.dart';
import 'fee_structure_list_screen.dart';
import 'payment_records_screen.dart';


class FeeManagementScreen extends ConsumerWidget {
  const FeeManagementScreen({super.key});

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
          'Fee Management',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        children: [
          // ======================================================
          // OVERVIEW
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

          const SizedBox(height: 22),

          // ======================================================
          // CREATE FEE STRUCTURE
          // ======================================================
          _ActionCard(
            icon: Icons.receipt_long_outlined,
            title: 'Create Fee Structure',
            subtitle: 'Prepare a detailed fee structure for your client.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeeStructureScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          // ======================================================
          // FEE STRUCTURES
          // ======================================================
          _ActionCard(
            icon: Icons.description_outlined,
            title: 'Fee Structures',
            subtitle: 'View and manage fee structures prepared for clients.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FeeStructureListScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // ======================================================
          // PAYMENT RECORDS
          // ======================================================
          _ActionCard(
  icon: Icons.payments_outlined,
  title: 'Payment Records',
  subtitle: 'View received and pending client payments.',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PaymentRecordsScreen(),
      ),
    );
  },
),

          const SizedBox(height: 24),

          // ======================================================
          // CURRENT FEE RECORDS
          // ======================================================
          const Text(
            'Current Fee Records',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),

          const SizedBox(height: 12),

          if (fees.isEmpty)
            const _EmptyFeeState()
          else
            ...fees.map(
              (fee) => _FeeRecordCard(
                clientName: fee.clientName,
                caseTitle: fee.caseTitle,
                totalFee: fee.totalFee,
                paidAmount: fee.paidAmount,
                remainingAmount: fee.remainingAmount,
                paymentStatus: fee.paymentStatus,
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
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
            child: Icon(icon, color: iconColor, size: 20),
          ),

          const SizedBox(height: 10),

          Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),

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
// ACTION CARD
// ======================================================

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: Color(0xFFD4AF37),
                  size: 22,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13294B),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right_rounded, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// FEE RECORD
// ======================================================

class _FeeRecordCard extends StatelessWidget {
  const _FeeRecordCard({
    required this.clientName,
    required this.caseTitle,
    required this.totalFee,
    required this.paidAmount,
    required this.remainingAmount,
    required this.paymentStatus,
  });

  final String clientName;
  final String? caseTitle;
  final double totalFee;
  final double paidAmount;
  final double remainingAmount;
  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                color: Color(0xFF13294B),
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  clientName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF13294B),
                  ),
                ),
              ),

              Text(
                paymentStatus,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: paymentStatus.toLowerCase() == 'paid'
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            ],
          ),

          if (caseTitle != null && caseTitle!.trim().isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              caseTitle!,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],

          const Divider(height: 20),

          Row(
            children: [
              Expanded(
                child: _AmountItem(label: 'Total', amount: totalFee),
              ),
              Expanded(
                child: _AmountItem(label: 'Paid', amount: paidAmount),
              ),
              Expanded(
                child: _AmountItem(label: 'Pending', amount: remainingAmount),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ======================================================
// AMOUNT ITEM
// ======================================================

class _AmountItem extends StatelessWidget {
  const _AmountItem({required this.label, required this.amount});

  final String label;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
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
// EMPTY STATE
// ======================================================

class _EmptyFeeState extends StatelessWidget {
  const _EmptyFeeState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 40,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Text(
            'No fee records yet',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF13294B),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Create a fee structure to get started.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/clerk_providers.dart';
import '../screens/fee_management_screen.dart';


class FeeManagementCard extends ConsumerWidget {
  const FeeManagementCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fees = ref.watch(clerkFeesProvider);

    // ======================================================
    // CALCULATIONS
    // ======================================================

    final received = fees.fold<double>(
      0,
      (sum, fee) => sum + fee.paidAmount,
    );

    final pending = fees.fold<double>(
      0,
      (sum, fee) => sum + fee.remainingAmount,
    );

    final now = DateTime.now();

    final thisMonth = fees
        .where(
          (fee) =>
              fee.updatedAt.year == now.year &&
              fee.updatedAt.month == now.month,
        )
        .fold<double>(
          0,
          (sum, fee) => sum + fee.paidAmount,
        );

    final clientIds = fees
        .map((fee) => fee.clientId)
        .where((id) => id.isNotEmpty)
        .toSet();

    final clientCount = clientIds.length;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FeeManagementScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======================================================
              // HEADER
              // ======================================================

              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37)
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Color(0xFFD4AF37),
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fee Management',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF13294B),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Manage fees and client fee structures',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ======================================================
              // RECEIVED + PENDING
              // ======================================================

              Row(
                children: [
                  Expanded(
                    child: _FeeItem(
                      title: 'Received',
                      amount: _formatCurrency(received),
                      icon: Icons.arrow_downward_rounded,
                      iconColor: Colors.green,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _FeeItem(
                      title: 'Pending',
                      amount: _formatCurrency(pending),
                      icon: Icons.access_time_rounded,
                      iconColor: Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ======================================================
              // THIS MONTH + CLIENTS
              // ======================================================

              Row(
                children: [
                  Expanded(
                    child: _FeeItem(
                      title: 'This Month',
                      amount: _formatCurrency(thisMonth),
                      icon: Icons.calendar_month_outlined,
                      iconColor: const Color(0xFF13294B),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _FeeItem(
                      title: 'Clients',
                      amount: '$clientCount',
                      icon: Icons.people_outline,
                      iconColor: const Color(0xFFD4AF37),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ======================================================
  // CURRENCY FORMAT
  // ======================================================

  String _formatCurrency(double amount) {
    return 'Rs. ${amount.toStringAsFixed(0)}';
  }
}

// ======================================================
// FEE ITEM
// ======================================================

class _FeeItem extends StatelessWidget {
  const _FeeItem({
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
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  amount,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF13294B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
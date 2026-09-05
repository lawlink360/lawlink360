import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/admin_transactions_provider.dart';
import '../widgets/transaction_status_chip.dart';

class AdminTransactionDetailsScreen extends ConsumerWidget {
  final String transactionId;

  const AdminTransactionDetailsScreen({
    super.key,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminTransactionsProvider.notifier);
    final transaction =
        notifier.getTransactionById(transactionId);

    if (transaction == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Transaction Details'),
        ),
        body: const Center(
          child: Text('Transaction not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.receipt_long_outlined,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'PKR ${transaction.amount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TransactionStatusChip(
                    status: transaction.status,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    transaction.transactionId,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _InfoCard(
            title: 'Transaction Information',
            rows: [
              _InfoRow('Transaction ID', transaction.transactionId),
              _InfoRow('Payment ID', transaction.paymentId),
              _InfoRow('Type', transaction.type),
              _InfoRow('Status', transaction.status),
              _InfoRow('Reference', transaction.reference ?? 'N/A'),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'User Information',
            rows: [
              _InfoRow('Name', transaction.userName),
              _InfoRow('Email', transaction.userEmail),
              _InfoRow('User ID', transaction.userId),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Payment Information',
            rows: [
              _InfoRow('Method', transaction.paymentMethod),
              _InfoRow('Gateway', transaction.paymentGateway),
              _InfoRow('Currency', transaction.currency),
              _InfoRow('Amount', 'PKR ${transaction.amount.toStringAsFixed(0)}'),
            ],
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Description',
            rows: [
              _InfoRow('Details', transaction.description),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<_InfoRow> rows;

  const _InfoCard({
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 115,
                      child: Text(
                        row.label,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.color,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        row.value,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;

  const _InfoRow(
    this.label,
    this.value,
  );
}
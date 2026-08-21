import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/fee_structure_model.dart';
import '../providers/fee_structure_provider.dart';
import 'fee_structure_screen.dart';

class FeeStructureListScreen extends ConsumerWidget {
  const FeeStructureListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feeStructures = ref.watch(feeStructureProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Fee Structures',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: feeStructures.isEmpty
          ? const _EmptyFeeStructures()
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                30,
              ),
              itemCount: feeStructures.length,
              itemBuilder: (context, index) {
                final feeStructure = feeStructures[index];

                return _FeeStructureCard(
                  feeStructure: feeStructure,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FeeStructureScreen(
                          feeStructure: feeStructure,
                        ),
                      ),
                    );
                  },
                  onDelete: () {
                    _confirmDelete(
                      context,
                      ref,
                      feeStructure,
                    );
                  },
                );
              },
            ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    FeeStructureModel feeStructure,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Fee Structure?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),
          content: const Text(
            'This fee structure will be permanently removed.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ref
                    .read(feeStructureProvider.notifier)
                    .removeFeeStructure(
                      feeStructure.id,
                    );

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Fee structure deleted.',
                    ),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// FEE STRUCTURE CARD
// ============================================================

class _FeeStructureCard extends StatelessWidget {
  const _FeeStructureCard({
    required this.feeStructure,
    required this.onTap,
    required this.onDelete,
  });

  final FeeStructureModel feeStructure;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final pending = feeStructure.remainingAmount;
    final paid = feeStructure.paidAmount;
    final total = feeStructure.totalAmount;

    final isPaid = pending <= 0 && total > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ==================================================
                // TOP ROW
                // ==================================================

                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.receipt_long_outlined,
                        color: Color(0xFFD4AF37),
                        size: 23,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            feeStructure.clientName
                                    ?.trim()
                                    .isNotEmpty ==
                                true
                                ? feeStructure.clientName!
                                : 'Unnamed Client',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF13294B),
                            ),
                          ),

                          const SizedBox(height: 4),

                          if (feeStructure.caseTitle
                                  ?.trim()
                                  .isNotEmpty ==
                              true)
                            Text(
                              feeStructure.caseTitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: isPaid
                            ? Colors.green.withValues(
                                alpha: 0.10,
                              )
                            : Colors.orange.withValues(
                                alpha: 0.10,
                              ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isPaid ? 'Paid' : 'Pending',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isPaid
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                const Divider(
                  height: 1,
                  color: Color(0xFFE5E7EB),
                ),

                const SizedBox(height: 14),

                // ==================================================
                // AMOUNTS
                // ==================================================

                Row(
                  children: [
                    Expanded(
                      child: _AmountColumn(
                        label: 'Total',
                        amount: total,
                      ),
                    ),

                    Expanded(
                      child: _AmountColumn(
                        label: 'Paid',
                        amount: paid,
                      ),
                    ),

                    Expanded(
                      child: _AmountColumn(
                        label: 'Pending',
                        amount: pending,
                        highlight: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ==================================================
                // ACTIONS
                // ==================================================

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 17,
                        ),
                        label: const Text(
                          'View / Edit',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color(0xFF13294B),
                          side: const BorderSide(
                            color: Color(0xFF13294B),
                          ),
                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 9,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    IconButton(
                      tooltip: 'Delete',
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 21,
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

// ============================================================
// AMOUNT COLUMN
// ============================================================

class _AmountColumn extends StatelessWidget {
  const _AmountColumn({
    required this.label,
    required this.amount,
    this.highlight = false,
  });

  final String label;
  final double amount;
  final bool highlight;

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

        const SizedBox(height: 4),

        Text(
          'Rs. ${amount.toStringAsFixed(2)}/-',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: highlight
                ? const Color(0xFFD4AF37)
                : const Color(0xFF13294B),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// EMPTY STATE
// ============================================================

class _EmptyFeeStructures
    extends StatelessWidget {
  const _EmptyFeeStructures();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37)
                    .withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 38,
                color: Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'No Fee Structures Yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Create a fee structure for a client and it will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const FeeStructureScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 18,
              ),
              label: const Text(
                'Create Fee Structure',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFD4AF37),
                foregroundColor:
                    const Color(0xFF13294B),
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 11,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
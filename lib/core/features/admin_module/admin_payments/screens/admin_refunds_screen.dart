import 'package:flutter/material.dart';

import '../../widgets/admin_drawer.dart';
import '../data/mock/admin_payments_mock_data.dart';
import '../models/refund_model.dart';
import '../widgets/payment_stats_card.dart';

class AdminRefundsScreen extends StatefulWidget {
  const AdminRefundsScreen({super.key});

  @override
  State<AdminRefundsScreen> createState() => _AdminRefundsScreenState();
}

class _AdminRefundsScreenState extends State<AdminRefundsScreen> {
  late List<RefundModel> _refunds;

  String _searchQuery = '';
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    _refunds = List<RefundModel>.from(
      AdminPaymentsMockData.refunds,
    );
  }

  List<RefundModel> get _filteredRefunds {
    return _refunds.where((refund) {
      final query = _searchQuery.toLowerCase();

      final matchesSearch =
          query.isEmpty ||
          refund.clientName.toLowerCase().contains(query) ||
          refund.lawyerName.toLowerCase().contains(query) ||
          refund.transactionId.toLowerCase().contains(query) ||
          refund.id.toLowerCase().contains(query);

      final matchesStatus =
          _selectedStatus == 'All' ||
          refund.status.toLowerCase() ==
              _selectedStatus.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();
  }

double get _totalRefundAmount {
  var total = 0.0;

  for (final refund in _refunds) {
    total += refund.refundAmount;
  }

  return total;
}

double get _pendingRefundAmount {
  var total = 0.0;

  for (final refund in _refunds) {
    if (refund.status == 'Pending') {
      total += refund.refundAmount;
    }
  }

  return total;
}

double get _completedRefundAmount {
  var total = 0.0;

  for (final refund in _refunds) {
    if (refund.status == 'Completed') {
      total += refund.refundAmount;
    }
  }

  return total;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refunds'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _resetRefunds,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: 6,
        onItemSelected: (index) {},
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildStats(),
            _buildSearch(),
            _buildStatusFilters(),
            Expanded(child: _buildRefundList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Refund Management',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStats() {
  return SizedBox(
    height: 110,
    child: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Requests',
            value: _refunds.length.toString(),
            icon: Icons.assignment_return,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Total',
            value: 'PKR ${_totalRefundAmount.toStringAsFixed(0)}',
            icon: Icons.currency_exchange,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Pending',
            value: 'PKR ${_pendingRefundAmount.toStringAsFixed(0)}',
            icon: Icons.pending_actions,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Completed',
            value: 'PKR ${_completedRefundAmount.toStringAsFixed(0)}',
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search client, lawyer or transaction...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusFilters() {
    const statuses = [
      'All',
      'Pending',
      'Completed',
      'Rejected',
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = statuses[index];
          final selected = _selectedStatus == status;

          return ChoiceChip(
            label: Text(status),
            selected: selected,
            onSelected: (_) {
              setState(() {
                _selectedStatus = status;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildRefundList() {
    final refunds = _filteredRefunds;

    if (refunds.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_return_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No refunds found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Try changing your search or status filter.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _resetRefunds();
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: refunds.length,
        separatorBuilder: (_, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final refund = refunds[index];

          return _RefundCard(
            refund: refund,
            onTap: () => _showRefundDetails(refund),
            onApprove: refund.status == 'Pending'
                ? () => _confirmRefundAction(
                      refund,
                      approve: true,
                    )
                : null,
            onReject: refund.status == 'Pending'
                ? () => _confirmRefundAction(
                      refund,
                      approve: false,
                    )
                : null,
          );
        },
      ),
    );
  }

  void _resetRefunds() {
    setState(() {
      _refunds = List<RefundModel>.from(
        AdminPaymentsMockData.refunds,
      );
    });
  }

  Future<void> _confirmRefundAction(
    RefundModel refund, {
    required bool approve,
  }) async {
    final action = approve ? 'approve' : 'reject';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${approve ? 'Approve' : 'Reject'} Refund'),
          content: Text(
            'Are you sure you want to $action this refund '
            'request for ${refund.clientName}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(approve ? 'Approve' : 'Reject'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    setState(() {
      final index = _refunds.indexWhere(
        (item) => item.id == refund.id,
      );

      if (index == -1) {
        return;
      }

      final now = DateTime.now();

      _refunds[index] = refund.copyWith(
        status: approve ? 'Completed' : 'Rejected',
        processedBy: 'Admin',
        processedAt: now,
        updatedAt: now,
      );
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Refund ${approve ? 'approved' : 'rejected'} successfully.',
        ),
      ),
    );
  }

  void _showRefundDetails(RefundModel refund) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Refund Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _DetailRow(
                label: 'Client',
                value: refund.clientName,
              ),
              _DetailRow(
                label: 'Lawyer',
                value: refund.lawyerName,
              ),
              _DetailRow(
                label: 'Transaction',
                value: refund.transactionId,
              ),
              _DetailRow(
                label: 'Original Amount',
                value:
                    'PKR ${refund.originalAmount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Refund Amount',
                value:
                    'PKR ${refund.refundAmount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Status',
                value: refund.status,
              ),
              _DetailRow(
                label: 'Reason',
                value: refund.reason,
              ),
              if (refund.notes != null)
                _DetailRow(
                  label: 'Notes',
                  value: refund.notes!,
                ),
              if (refund.processedBy != null)
                _DetailRow(
                  label: 'Processed By',
                  value: refund.processedBy!,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _RefundCard extends StatelessWidget {
  final RefundModel refund;
  final VoidCallback? onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const _RefundCard({
    required this.refund,
    this.onTap,
    this.onApprove,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(refund.status);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      refund.clientName.isNotEmpty
                          ? refund.clientName[0].toUpperCase()
                          : '?',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          refund.clientName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          refund.transactionId,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      refund.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                refund.lawyerName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                refund.reason,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Refund: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'PKR ${refund.refundAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(refund.requestedAt),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              if (onApprove != null || onReject != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (onApprove != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onApprove,
                          icon: const Icon(Icons.check),
                          label: const Text('Approve'),
                        ),
                      ),
                    if (onApprove != null && onReject != null)
                      const SizedBox(width: 8),
                    if (onReject != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onReject,
                          icon: const Icon(Icons.close),
                          label: const Text('Reject'),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../widgets/admin_drawer.dart';
import '../data/mock/admin_payments_mock_data.dart';
import '../models/commission_model.dart';
import '../widgets/commission_card.dart';
import '../widgets/payment_stats_card.dart';

class AdminCommissionsScreen extends StatefulWidget {
  const AdminCommissionsScreen({super.key});

  @override
  State<AdminCommissionsScreen> createState() =>
      _AdminCommissionsScreenState();
}

class _AdminCommissionsScreenState extends State<AdminCommissionsScreen> {
  late List<CommissionModel> _commissions;

  String _searchQuery = '';
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    _commissions = List<CommissionModel>.from(
      AdminPaymentsMockData.commissions,
    );
  }

  List<CommissionModel> get _filteredCommissions {
    return _commissions.where((commission) {
      final query = _searchQuery.toLowerCase();

      final matchesSearch =
          query.isEmpty ||
          commission.lawyerName.toLowerCase().contains(query) ||
          commission.transactionId.toLowerCase().contains(query) ||
          commission.id.toLowerCase().contains(query);

      final matchesStatus =
          _selectedStatus == 'All' ||
          commission.status.toLowerCase() ==
              _selectedStatus.toLowerCase();

      return matchesSearch && matchesStatus;
    }).toList();
  }

  double get _totalCommission {
    return _commissions.fold(
      0,
      (sum, commission) => sum + commission.commissionAmount,
    );
  }

  double get _paidCommission {
    return _commissions
        .where((commission) => commission.status == 'Paid')
        .fold(
          0,
          (sum, commission) => sum + commission.commissionAmount,
        );
  }

  double get _pendingCommission {
    return _commissions
        .where((commission) => commission.status == 'Pending')
        .fold(
          0,
          (sum, commission) => sum + commission.commissionAmount,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Commissions'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              setState(() {
                _commissions = List<CommissionModel>.from(
                  AdminPaymentsMockData.commissions,
                );
              });
            },
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
            Expanded(child: _buildCommissionList()),
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
          'Commission Management',
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
            title: 'Total',
            value: _commissions.length.toString(),
            icon: Icons.receipt_long,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Commission',
            value: 'PKR ${_totalCommission.toStringAsFixed(0)}',
            icon: Icons.account_balance_wallet,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Paid',
            value: 'PKR ${_paidCommission.toStringAsFixed(0)}',
            icon: Icons.paid,
            color: Colors.teal,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: PaymentStatsCard(
            title: 'Pending',
            value: 'PKR ${_pendingCommission.toStringAsFixed(0)}',
            icon: Icons.pending_actions,
            color: Colors.orange,
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
          hintText: 'Search lawyer or transaction...',
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
    const statuses = ['All', 'Paid', 'Pending'];

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

  Widget _buildCommissionList() {
    final commissions = _filteredCommissions;

    if (commissions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No commissions found',
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
        setState(() {
          _commissions = List<CommissionModel>.from(
            AdminPaymentsMockData.commissions,
          );
        });
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: commissions.length,
        separatorBuilder: (_, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final commission = commissions[index];

          return CommissionCard(
            commission: commission,
            onTap: () => _showCommissionDetails(commission),
          );
        },
      ),
    );
  }

  void _showCommissionDetails(CommissionModel commission) {
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
                'Commission Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _DetailRow(
                label: 'Lawyer',
                value: commission.lawyerName,
              ),
              _DetailRow(
                label: 'Transaction',
                value: commission.transactionId,
              ),
              _DetailRow(
                label: 'Payment Amount',
                value:
                    'PKR ${commission.paymentAmount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Commission Rate',
                value: '${commission.commissionRate}%',
              ),
              _DetailRow(
                label: 'Commission',
                value:
                    'PKR ${commission.commissionAmount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Lawyer Amount',
                value:
                    'PKR ${commission.lawyerAmount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Status',
                value: commission.status,
              ),
              _DetailRow(
                label: 'Created',
                value: _formatDate(commission.createdAt),
              ),
              if (commission.paidAt != null)
                _DetailRow(
                  label: 'Paid',
                  value: _formatDate(commission.paidAt!),
                ),
            ],
          ),
        );
      },
    );
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
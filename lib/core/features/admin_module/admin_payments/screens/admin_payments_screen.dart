import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/admin_drawer.dart';
import '../providers/admin_payments_provider.dart';
import '../widgets/admin_payment_card.dart';
import '../widgets/payment_filter_sheet.dart';
import '../widgets/payment_stats_card.dart';

class AdminPaymentsScreen extends ConsumerStatefulWidget {
  const AdminPaymentsScreen({super.key});

  @override
  ConsumerState<AdminPaymentsScreen> createState() =>
      _AdminPaymentsScreenState();
}

class _AdminPaymentsScreenState
    extends ConsumerState<AdminPaymentsScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentsState = ref.watch(adminPaymentsProvider);
    final notifier = ref.read(adminPaymentsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Payments'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              notifier.refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: 6,
        onItemSelected: (index) {
          Navigator.pop(context);
        },
      ),
      body: paymentsState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _ErrorView(
          onRetry: notifier.refresh,
        ),
        data: (_) => RefreshIndicator(
          onRefresh: notifier.refresh,
          child: _buildContent(context, notifier),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AdminPaymentsNotifier notifier,
  ) {
    final payments = notifier.filteredPayments;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          sliver: SliverToBoxAdapter(
            child: _buildHeader(context),
          ),
        ),
        SliverToBoxAdapter(
          child: _buildStats(notifier),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          sliver: SliverToBoxAdapter(
            child: _buildSearchAndFilter(context, notifier),
          ),
        ),
        if (payments.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyPaymentsView(),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];

                return AdminPaymentCard(
                  payment: payment,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _PaymentDetailsScreen(
                          paymentId: payment.id,
                        ),
                      ),
                    );
                  },
                  onMarkCompleted: () {
                    notifier.updatePaymentStatus(
                      payment.id,
                      'Completed',
                    );
                  },
                  onRefund: () {
                    notifier.updatePaymentStatus(
                      payment.id,
                      'Refunded',
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Management',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Monitor payments, revenue, platform fees, and refunds.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildStats(AdminPaymentsNotifier notifier) {
    return SizedBox(
      height: 125,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        children: [
          PaymentStatsCard(
            title: 'Total Payments',
            value: notifier.totalCount.toString(),
            icon: Icons.payments_outlined,
            color: Colors.blue,
          ),
          const SizedBox(width: 12),
          PaymentStatsCard(
            title: 'Revenue',
            value: _formatCurrency(notifier.totalRevenue),
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          PaymentStatsCard(
            title: 'Platform Fees',
            value: _formatCurrency(notifier.totalPlatformFees),
            icon: Icons.business_center_outlined,
            color: Colors.orange,
          ),
          const SizedBox(width: 12),
          PaymentStatsCard(
            title: 'Refunded',
            value: _formatCurrency(notifier.totalRefunded),
            icon: Icons.currency_exchange,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(
    BuildContext context,
    AdminPaymentsNotifier notifier,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            onChanged: notifier.search,
            decoration: InputDecoration(
              hintText: 'Search payments...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        notifier.search('');
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear),
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton.filledTonal(
          tooltip: 'Filters',
          onPressed: () {
            PaymentFilterSheet.show(
              context: context,
              selectedStatus: notifier.selectedStatus,
              selectedPaymentMethod: notifier.selectedPaymentMethod,
              selectedPaymentGateway: notifier.selectedPaymentGateway,
              onStatusChanged: notifier.filterByStatus,
              onPaymentMethodChanged:
                  notifier.filterByPaymentMethod,
              onPaymentGatewayChanged:
                  notifier.filterByPaymentGateway,
              onClear: () {
                notifier.clearFilters();
                _searchController.clear();
                setState(() {});
              },
            );
          },
          icon: const Icon(Icons.filter_list),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    return 'PKR ${amount.toStringAsFixed(0)}';
  }
}

class _PaymentDetailsScreen extends ConsumerWidget {
  final String paymentId;

  const _PaymentDetailsScreen({
    required this.paymentId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(adminPaymentsProvider.notifier);
    final payment = notifier.getPaymentById(paymentId);

    if (payment == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Details'),
        ),
        body: const Center(
          child: Text('Payment not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AdminPaymentCard(payment: payment),
          const SizedBox(height: 16),
          _DetailsCard(
            title: 'Payment Information',
            children: [
              _DetailRow(
                label: 'Transaction ID',
                value: payment.transactionId,
              ),
              _DetailRow(
                label: 'Amount',
                value: 'PKR ${payment.amount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Payment Method',
                value: payment.paymentMethod,
              ),
              _DetailRow(
                label: 'Gateway',
                value: payment.paymentGateway,
              ),
              _DetailRow(
                label: 'Status',
                value: payment.status,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _DetailsCard(
            title: 'Financial Breakdown',
            children: [
              _DetailRow(
                label: 'Total Amount',
                value: 'PKR ${payment.amount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Platform Fee',
                value:
                    'PKR ${payment.platformFee.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Lawyer Amount',
                value:
                    'PKR ${payment.lawyerAmount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Refunded Amount',
                value:
                    'PKR ${payment.refundedAmount.toStringAsFixed(0)}',
              ),
            ],
          ),
          const SizedBox(height: 12),
          _DetailsCard(
            title: 'Client',
            children: [
              _DetailRow(
                label: 'Name',
                value: payment.clientName,
              ),
              _DetailRow(
                label: 'Email',
                value: payment.clientEmail,
              ),
              _DetailRow(
                label: 'Client ID',
                value: payment.clientId,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _DetailsCard(
            title: 'Lawyer',
            children: [
              _DetailRow(
                label: 'Name',
                value: payment.lawyerName,
              ),
              _DetailRow(
                label: 'Lawyer ID',
                value: payment.lawyerId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailsCard({
    required this.title,
    required this.children,
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
            ...children,
          ],
        ),
      ),
    );
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
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
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPaymentsView extends StatelessWidget {
  const _EmptyPaymentsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.payments_outlined,
              size: 56,
              color: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.color,
            ),
            const SizedBox(height: 12),
            const Text(
              'No payments found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try changing your search or filters.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Unable to load payments.'),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
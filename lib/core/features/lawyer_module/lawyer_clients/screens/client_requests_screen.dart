import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/client_requests_provider.dart';
import '../widgets/lawyer_clients_empty_state.dart';
import '../widgets/lawyer_clients_header.dart';
import '../widgets/lawyer_clients_request_card.dart';
import '../models/client_request_model.dart';

class ClientRequestsScreen extends ConsumerWidget {
  const ClientRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(clientRequestsProvider);

    final pendingRequests = requests
        .where(
          (request) =>
              request.status == ClientRequestStatus.pending,
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Client Requests',
          style: TextStyle(
            color: Color(0xFF13294B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: pendingRequests.isEmpty
            ? const LawyerClientEmptyState(
                title: 'No Pending Requests',
                message:
                    'New client requests will appear here when clients request your legal services.',
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref
                      .read(clientRequestsProvider.notifier)
                      .refreshRequests();
                },
                child: ListView(
                  physics:
                      const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    18,
                    20,
                    40,
                  ),
                  children: [
                    const LawyerClientsHeader(),

                    const SizedBox(height: 20),

                    const Text(
                      'Pending Requests',
                      style: TextStyle(
                        color: Color(0xFF13294B),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...pendingRequests.map(
                      (request) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: LawyerClientsRequestCard(
                          clientName: request.clientName,
                          requestType: request.requestType,
                          message: request.message,
                          requestedAt:
                              _formatRequestDate(
                            request.requestedAt,
                          ),
                          imageUrl:
                              request.clientImageUrl,
                          onAccept: () {
                            ref
                                .read(
                                  clientRequestsProvider
                                      .notifier,
                                )
                                .acceptRequest(request.id);
                          },
                          onDecline: () {
                            ref
                                .read(
                                  clientRequestsProvider
                                      .notifier,
                                )
                                .declineRequest(request.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String _formatRequestDate(DateTime date) {
    final now = DateTime.now();

    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }

    if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
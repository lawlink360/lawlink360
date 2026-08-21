
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/lawyer_clients_provider.dart';
import '../widgets/lawyer_client_card.dart';
import '../widgets/lawyer_clients_empty_state.dart';
import '../widgets/lawyer_clients_header.dart';
import '../widgets/lawyer_clients_overview_card.dart';
import '../widgets/lawyer_clients_search_bar.dart';
import 'client_profile_screen.dart';

class MyClientsScreen extends ConsumerWidget {
  const MyClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const background = Color(0xFFF5F7FB);
    const navy = Color(0xFF13294B);

    final clients = ref.watch(lawyerClientsProvider);

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Clients',
          style: TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: clients.isEmpty
            ? const LawyerClientEmptyState()
            : RefreshIndicator(
                onRefresh: () async {
                  ref
                      .read(lawyerClientsProvider.notifier)
                      .refreshClients();
                },

                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    18,
                    20,
                    30,
                  ),

                  children: [
                    // ------------------------------------------------
                    // HEADER
                    // ------------------------------------------------

                    const LawyerClientsHeader(),

                    const SizedBox(height: 18),

                    // ------------------------------------------------
                    // OVERVIEW
                    // ------------------------------------------------

                    const LawyerClientsOverviewCard(),

                    const SizedBox(height: 22),

                    // ------------------------------------------------
                    // SEARCH
                    // ------------------------------------------------

                    const LawyerClientsSearchBar(),

                    const SizedBox(height: 22),

                    // ------------------------------------------------
                    // ALL CLIENTS
                    // ------------------------------------------------

                    const Text(
                      'All Clients',
                      style: TextStyle(
                        color: navy,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ------------------------------------------------
                    // COMPLETE CLIENT LIST
                    // ------------------------------------------------

                    ...clients.map(
                      (client) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: LawyerClientCard(
                          name: client.name,
                          imageUrl: client.imageUrl,
                          city: client.city,
                          caseTitle: client.caseTitle,
                          caseStatus: client.caseStatus,
                          lastActivity: client.lastActivity,
                          activeCases: client.activeCases,

                          onProfile: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ClientProfileScreen(
                                  clientId: client.id,
                                ),
                              ),
                            );
                          },

                          onChat: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Opening chat with ${client.name}',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
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
}

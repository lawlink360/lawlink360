import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/lawyer_client_model.dart';
import 'lawyer_clients_provider.dart';

final clientSearchQueryProvider =
    StateProvider<String>((ref) => '');

final filteredLawyerClientsProvider =
    Provider<List<LawyerClientModel>>((ref) {
  final query = ref.watch(clientSearchQueryProvider);
  final clients = ref.watch(lawyerClientsProvider);

  final normalizedQuery = query.trim().toLowerCase();

  if (normalizedQuery.isEmpty) {
    return clients;
  }

  return clients.where((client) {
    return client.name.toLowerCase().contains(normalizedQuery) ||
        client.city.toLowerCase().contains(normalizedQuery) ||
        client.caseTitle.toLowerCase().contains(normalizedQuery) ||
        client.caseStatus.toLowerCase().contains(normalizedQuery);
  }).toList();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/client_mock_data.dart';
import '../models/lawyer_client_model.dart';

class LawyerClientsNotifier
    extends StateNotifier<List<LawyerClientModel>> {
  LawyerClientsNotifier()
      : super(List<LawyerClientModel>.from(
          ClientMockData.clients,
        ));

  /// Refresh clients from the current data source.
  ///
  /// At the moment this uses mock data.
  /// Later this method will load clients from Firebase.
  void refreshClients() {
    state = List<LawyerClientModel>.from(
      ClientMockData.clients,
    );
  }

  /// Search clients by name, city, case title or case status.
  List<LawyerClientModel> searchClients(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return state;
    }

    return state.where((client) {
      return client.name.toLowerCase().contains(normalizedQuery) ||
          client.city.toLowerCase().contains(normalizedQuery) ||
          client.caseTitle.toLowerCase().contains(normalizedQuery) ||
          client.caseStatus.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  /// Find one client by ID.
  LawyerClientModel? getClientById(String clientId) {
    for (final client in state) {
      if (client.id == clientId) {
        return client;
      }
    }

    return null;
  }

  /// Add a client to the current lawyer's client list.
  void addClient(LawyerClientModel client) {
    final alreadyExists =
        state.any((existing) => existing.id == client.id);

    if (alreadyExists) {
      return;
    }

    state = [
      ...state,
      client,
    ];
  }

  /// Remove a client.
  void removeClient(String clientId) {
    state = state
        .where((client) => client.id != clientId)
        .toList();
  }

  /// Update an existing client.
  void updateClient(LawyerClientModel updatedClient) {
    state = [
      for (final client in state)
        if (client.id == updatedClient.id)
          updatedClient
        else
          client,
    ];
  }

  /// Number of active clients.
  int get activeClientsCount {
    return state.length;
  }

  /// Number of active cases belonging to all clients.
  int get activeCasesCount {
    return state.fold(
      0,
      (total, client) => total + client.activeCases,
    );
  }

  /// Number of total cases belonging to all clients.
  int get totalCasesCount {
    return state.fold(
      0,
      (total, client) => total + client.totalCases,
    );
  }
}

final lawyerClientsProvider = StateNotifierProvider<
    LawyerClientsNotifier,
    List<LawyerClientModel>>(
  (ref) {
    return LawyerClientsNotifier();
  },
);
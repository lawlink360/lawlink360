import '../data/client_mock_data.dart';
import '../models/client_activity_model.dart';
import '../models/client_case_summary_model.dart';
import '../models/client_request_model.dart';
import '../models/lawyer_client_model.dart';

class LawyerClientService {
  const LawyerClientService();

  // ============================================================
  // CLIENTS
  // ============================================================

  Future<List<LawyerClientModel>> getClients() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<LawyerClientModel>.from(
      ClientMockData.clients,
    );
  }

  Future<LawyerClientModel?> getClientById(
    String clientId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return ClientMockData.findClientById(clientId);
  }

  // ============================================================
  // CLIENT CASES
  // ============================================================

  Future<List<ClientCaseSummaryModel>> getClientCases(
    String clientId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    return ClientMockData.casesForClient(clientId);
  }

  // ============================================================
  // CLIENT ACTIVITY
  // ============================================================

  Future<List<ClientActivityModel>> getClientActivities(
    String clientId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    return ClientMockData.activitiesForClient(clientId);
  }

  // ============================================================
  // CLIENT REQUESTS
  // ============================================================

  Future<List<ClientRequestModel>> getClientRequests() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    return List<ClientRequestModel>.from(
      ClientMockData.requests,
    );
  }

  Future<List<ClientRequestModel>> getPendingRequests() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return ClientMockData.pendingRequests();
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Future<List<LawyerClientModel>> searchClients(
    String query,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<LawyerClientModel>.from(
        ClientMockData.clients,
      );
    }

    return ClientMockData.clients.where((client) {
      return client.name.toLowerCase().contains(normalizedQuery) ||
          client.city.toLowerCase().contains(normalizedQuery) ||
          client.caseTitle.toLowerCase().contains(normalizedQuery) ||
          client.caseStatus.toLowerCase().contains(normalizedQuery);
    }).toList();
  }
}
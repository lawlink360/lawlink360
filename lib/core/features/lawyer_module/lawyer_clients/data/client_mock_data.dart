import 'client_data.dart';
import '../models/client_activity_model.dart';
import '../models/client_case_summary_model.dart';
import '../models/client_request_model.dart';
import '../models/lawyer_client_model.dart';

class ClientMockData {
  const ClientMockData._();

  static List<LawyerClientModel> get clients {
    return List<LawyerClientModel>.unmodifiable(
      ClientData.clients,
    );
  }

  static List<ClientRequestModel> get requests {
    return List<ClientRequestModel>.unmodifiable(
      ClientData.requests,
    );
  }

  static List<ClientActivityModel> get activities {
    return List<ClientActivityModel>.unmodifiable(
      ClientData.activities,
    );
  }

  static List<ClientCaseSummaryModel> get cases {
    return List<ClientCaseSummaryModel>.unmodifiable(
      ClientData.cases,
    );
  }

  static LawyerClientModel? findClientById(String clientId) {
    for (final client in clients) {
      if (client.id == clientId) {
        return client;
      }
    }

    return null;
  }

  static List<ClientCaseSummaryModel> casesForClient(
    String clientId,
  ) {
    return cases
        .where((caseItem) => caseItem.clientId == clientId)
        .toList();
  }

  static List<ClientActivityModel> activitiesForClient(
    String clientId,
  ) {
    return activities
        .where((activity) => activity.clientId == clientId)
        .toList();
  }

  static List<ClientRequestModel> pendingRequests() {
    return requests
        .where(
          (request) =>
              request.status == ClientRequestStatus.pending,
        )
        .toList();
  }
}
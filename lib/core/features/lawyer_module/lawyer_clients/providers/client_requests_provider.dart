import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/client_mock_data.dart';
import '../models/client_request_model.dart';

class ClientRequestsNotifier
    extends StateNotifier<List<ClientRequestModel>> {
  ClientRequestsNotifier()
      : super(List<ClientRequestModel>.from(
          ClientMockData.requests,
        ));

  /// Refresh requests from the current data source.
  ///
  /// At the moment this uses mock data.
  /// Later this will load requests from Firebase.
  void refreshRequests() {
    state = List<ClientRequestModel>.from(
      ClientMockData.requests,
    );
  }

  /// Accept a client request.
  void acceptRequest(String requestId) {
    state = [
      for (final request in state)
        if (request.id == requestId)
          request.copyWith(
            status: ClientRequestStatus.accepted,
          )
        else
          request,
    ];
  }

  /// Decline a client request.
  void declineRequest(String requestId) {
    state = [
      for (final request in state)
        if (request.id == requestId)
          request.copyWith(
            status: ClientRequestStatus.declined,
          )
        else
          request,
    ];
  }

  /// Remove a request completely.
  void removeRequest(String requestId) {
    state = state
        .where((request) => request.id != requestId)
        .toList();
  }

  /// Return only pending requests.
  List<ClientRequestModel> get pendingRequests {
    return state
        .where(
          (request) =>
              request.status == ClientRequestStatus.pending,
        )
        .toList();
  }

  /// Return only accepted requests.
  List<ClientRequestModel> get acceptedRequests {
    return state
        .where(
          (request) =>
              request.status == ClientRequestStatus.accepted,
        )
        .toList();
  }

  /// Return only declined requests.
  List<ClientRequestModel> get declinedRequests {
    return state
        .where(
          (request) =>
              request.status == ClientRequestStatus.declined,
        )
        .toList();
  }

  /// Number of pending requests.
  int get pendingCount {
    return pendingRequests.length;
  }
}

final clientRequestsProvider = StateNotifierProvider<
    ClientRequestsNotifier,
    List<ClientRequestModel>>(
  (ref) {
    return ClientRequestsNotifier();
  },
);
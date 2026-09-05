import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_verification/data/mock/admin_verification_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_request_model.dart';

final verificationDetailsProvider = NotifierProviderFamily<
    VerificationDetailsNotifier,
    AsyncValue<VerificationRequestModel?>,
    String>(
  VerificationDetailsNotifier.new,
);

class VerificationDetailsNotifier
    extends FamilyNotifier<AsyncValue<VerificationRequestModel?>, String> {
  @override
  AsyncValue<VerificationRequestModel?> build(String requestId) {
    final request = AdminVerificationMockData.requests.cast<VerificationRequestModel?>().firstWhere(
      (item) => item?.id == requestId,
      orElse: () => null,
    );

    return AsyncValue.data(request);
  }

  void updateRequest(VerificationRequestModel request) {
    state = AsyncValue.data(request);
  }

  void setStatus(
    String status, {
    String? reviewerName,
    String? rejectionReason,
    String? notes,
  }) {
    final currentRequest = state.valueOrNull;

    if (currentRequest == null) {
      return;
    }

    state = AsyncValue.data(
      currentRequest.copyWith(
        status: status,
        reviewedAt: DateTime.now(),
        reviewerName: reviewerName,
        rejectionReason: rejectionReason,
        notes: notes,
      ),
    );
  }
}
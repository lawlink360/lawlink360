import 'package:lawlink360/core/features/admin_module/admin_verification/data/mock/admin_verification_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_document_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_verification/models/verification_request_model.dart';

class AdminVerificationService {
  AdminVerificationService._();

  static final AdminVerificationService instance =
      AdminVerificationService._();

  Future<List<VerificationRequestModel>> fetchVerificationRequests() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<VerificationRequestModel>.from(
      AdminVerificationMockData.requests,
    );
  }

  Future<List<VerificationRequestModel>>
      refreshVerificationRequests() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<VerificationRequestModel>.from(
      AdminVerificationMockData.requests,
    );
  }

  Future<VerificationRequestModel?> getVerificationRequestById(
    String requestId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    try {
      return AdminVerificationMockData.requests.firstWhere(
        (request) => request.id == requestId,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<VerificationRequestModel>> searchVerificationRequests(
    String query,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<VerificationRequestModel>.from(
        AdminVerificationMockData.requests,
      );
    }

    return AdminVerificationMockData.requests.where((request) {
      return request.applicantName
              .toLowerCase()
              .contains(normalizedQuery) ||
          request.email.toLowerCase().contains(normalizedQuery) ||
          request.phone.toLowerCase().contains(normalizedQuery) ||
          request.applicantId.toLowerCase().contains(normalizedQuery) ||
          request.applicantType.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  Future<List<VerificationRequestModel>> filterByStatus(
    String status,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminVerificationMockData.requests
        .where(
          (request) => request.status == status,
        )
        .toList();
  }

  Future<VerificationRequestModel> updateVerificationStatus({
    required VerificationRequestModel request,
    required String status,
    String? reviewerName,
    String? rejectionReason,
    String? notes,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return request.copyWith(
      status: status,
      reviewedAt: DateTime.now(),
      reviewerName: reviewerName,
      rejectionReason: rejectionReason,
      notes: notes,
    );
  }

  Future<List<VerificationDocumentModel>> getDocumentsForRequest(
    String requestId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    return _mockDocumentsForRequest(requestId);
  }

  Future<VerificationDocumentModel> updateDocumentStatus({
    required VerificationDocumentModel document,
    required String status,
    String? rejectionReason,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    return document.copyWith(
      status: status,
      rejectionReason: rejectionReason,
    );
  }

  List<VerificationDocumentModel> _mockDocumentsForRequest(
    String requestId,
  ) {
    return [
      VerificationDocumentModel(
        id: '${requestId}_document_001',
        verificationRequestId: requestId,
        documentType: 'Identity',
        documentName: 'CNIC',
        documentNumber: '35202-1234567-1',
        documentUrl: 'mock://documents/cnic.pdf',
        status: 'approved',
        uploadedAt: DateTime(2026, 8, 28, 10, 35),
      ),
      VerificationDocumentModel(
        id: '${requestId}_document_002',
        verificationRequestId: requestId,
        documentType: 'Professional',
        documentName: 'Bar Council Certificate',
        documentNumber: 'BC-2026-00125',
        documentUrl: 'mock://documents/bar_council_certificate.pdf',
        status: 'pending',
        uploadedAt: DateTime(2026, 8, 28, 10, 40),
      ),
      VerificationDocumentModel(
        id: '${requestId}_document_003',
        verificationRequestId: requestId,
        documentType: 'Education',
        documentName: 'Law Degree',
        documentNumber: 'LLB-2024-00891',
        documentUrl: 'mock://documents/law_degree.pdf',
        status: 'pending',
        uploadedAt: DateTime(2026, 8, 28, 10, 45),
      ),
    ];
  }
}
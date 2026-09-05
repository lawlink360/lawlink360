import 'package:lawlink360/core/features/admin_module/admin_lawyers/data/mock/admin_lawyer_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/models/admin_lawyer_model.dart';

class AdminLawyersService {
  const AdminLawyersService();

  Future<List<AdminLawyerModel>> fetchLawyers() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    return List<AdminLawyerModel>.from(
      AdminLawyerMockData.lawyers,
    );
  }

  Future<List<AdminLawyerModel>> refreshLawyers() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<AdminLawyerModel>.from(
      AdminLawyerMockData.lawyers,
    );
  }

  Future<AdminLawyerModel?> getLawyerById(
    String lawyerId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    for (final lawyer in AdminLawyerMockData.lawyers) {
      if (lawyer.id == lawyerId) {
        return lawyer;
      }
    }

    return null;
  }

  Future<void> updateLawyerStatus(
    String lawyerId,
    String status,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );
  }

  Future<void> updateApprovalStatus(
    String lawyerId,
    bool approved,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );
  }

  Future<List<AdminLawyerModel>> searchLawyers(
    String query,
  ) async {
    final lawyers = await fetchLawyers();

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return lawyers;
    }

    return lawyers.where((lawyer) {
      return lawyer.name
              .toLowerCase()
              .contains(normalizedQuery) ||
          lawyer.email
              .toLowerCase()
              .contains(normalizedQuery) ||
          lawyer.phone
              .toLowerCase()
              .contains(normalizedQuery) ||
          lawyer.specialization
              .toLowerCase()
              .contains(normalizedQuery) ||
          lawyer.city
              .toLowerCase()
              .contains(normalizedQuery);
    }).toList();
  }
}
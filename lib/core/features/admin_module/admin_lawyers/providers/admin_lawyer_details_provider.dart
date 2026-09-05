import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_lawyers/models/admin_lawyer_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/models/lawyer_performance_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/data/mock/admin_lawyer_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/services/admin_lawyers_service.dart';

final adminLawyerDetailsProvider = NotifierProviderFamily<
    AdminLawyerDetailsNotifier,
    AsyncValue<AdminLawyerModel?>,
    String>(
  AdminLawyerDetailsNotifier.new,
);

class AdminLawyerDetailsNotifier
    extends FamilyNotifier<
        AsyncValue<AdminLawyerModel?>,
        String> {
  final AdminLawyersService _service =
      const AdminLawyersService();

  @override
  AsyncValue<AdminLawyerModel?> build(
    String lawyerId,
  ) {
    Future.microtask(loadLawyer);

    return const AsyncValue.loading();
  }

  Future<void> loadLawyer() async {
    state = const AsyncValue.loading();

    try {
      final lawyer = await _service.getLawyerById(arg);

      state = AsyncValue.data(lawyer);
    } catch (error, stackTrace) {
      state = AsyncValue.error(
        error,
        stackTrace,
      );
    }
  }

  Future<void> refreshLawyer() async {
    await loadLawyer();
  }

  Future<void> updateStatus(String newStatus) async {
    final currentLawyer = state.valueOrNull;

    if (currentLawyer == null) {
      return;
    }

    final updatedLawyer = currentLawyer.copyWith(
      status: newStatus,
    );

    state = AsyncValue.data(updatedLawyer);
  }

  Future<void> updateApproval(bool approved) async {
    final currentLawyer = state.valueOrNull;

    if (currentLawyer == null) {
      return;
    }

    final updatedLawyer = currentLawyer.copyWith(
      isApproved: approved,
    );

    state = AsyncValue.data(updatedLawyer);
  }

  LawyerPerformanceModel? getPerformance() {
    for (final performance
        in AdminLawyerMockData.performances) {
      if (performance.lawyerId == arg) {
        return performance;
      }
    }

    return null;
  }

  void clearLawyer() {
    state = const AsyncValue.data(null);
  }
}
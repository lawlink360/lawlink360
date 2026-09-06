import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_lawyers/models/admin_lawyer_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_lawyers/services/admin_lawyers_service.dart';

final adminLawyersServiceProvider =
    Provider<AdminLawyersService>((ref) {
  return const AdminLawyersService();
});

final adminLawyersProvider =
    NotifierProvider<AdminLawyersNotifier, List<AdminLawyerModel>>(
  AdminLawyersNotifier.new,
);

class AdminLawyersNotifier
    extends Notifier<List<AdminLawyerModel>> {
  late final AdminLawyersService _service;

  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedSpecialization;
  String? _selectedCity;

  bool _isLoading = false;
  bool _isRefreshing = false;
  Object? _error;

  @override
  List<AdminLawyerModel> build() {
    _service = ref.watch(adminLawyersServiceProvider);

    return const [];
  }

  String get searchQuery => _searchQuery;

  String? get selectedStatus => _selectedStatus;

  String? get selectedSpecialization =>
      _selectedSpecialization;

  String? get selectedCity => _selectedCity;

  bool get isLoading => _isLoading;

  bool get isRefreshing => _isRefreshing;

  Object? get error => _error;

  bool get hasError => _error != null;

  List<AdminLawyerModel> get filteredLawyers {
    final query = _searchQuery.trim().toLowerCase();

    return state.where((lawyer) {
      final matchesSearch = query.isEmpty ||
          lawyer.name.toLowerCase().contains(query) ||
          lawyer.email.toLowerCase().contains(query) ||
          lawyer.phone.toLowerCase().contains(query) ||
          lawyer.specialization
              .toLowerCase()
              .contains(query) ||
          lawyer.city.toLowerCase().contains(query);

      final matchesStatus = _selectedStatus == null ||
          _selectedStatus!.isEmpty ||
          lawyer.status.toLowerCase() ==
              _selectedStatus!.toLowerCase();

      final matchesSpecialization =
          _selectedSpecialization == null ||
              _selectedSpecialization!.isEmpty ||
              lawyer.specialization.toLowerCase() ==
                  _selectedSpecialization!.toLowerCase();

      final matchesCity = _selectedCity == null ||
          _selectedCity!.isEmpty ||
          lawyer.city.toLowerCase() ==
              _selectedCity!.toLowerCase();

      return matchesSearch &&
          matchesStatus &&
          matchesSpecialization &&
          matchesCity;
    }).toList();
  }

  int get totalLawyers => state.length;

  int get activeLawyers => state
      .where(
        (lawyer) => lawyer.status.toLowerCase() == 'active',
      )
      .length;

  int get inactiveLawyers => state
      .where(
        (lawyer) => lawyer.status.toLowerCase() == 'inactive',
      )
      .length;

  int get suspendedLawyers => state
      .where(
        (lawyer) =>
            lawyer.status.toLowerCase() == 'suspended',
      )
      .length;

  int get pendingLawyers => state
      .where(
        (lawyer) => lawyer.status.toLowerCase() == 'pending',
      )
      .length;

  int get verifiedLawyers =>
      state.where((lawyer) => lawyer.isVerified).length;

  int get approvedLawyers =>
      state.where((lawyer) => lawyer.isApproved).length;

  Future<void> loadLawyers() async {
    _setLoading(true);
    _clearError();

    try {
      final lawyers = await _service.fetchLawyers();

      state = lawyers;
    } catch (error) {
      _error = error;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshLawyers() async {
    if (_isRefreshing) {
      return;
    }

    _isRefreshing = true;
    _clearError();

    try {
      final lawyers = await _service.refreshLawyers();

      state = lawyers;
    } catch (error) {
      _error = error;
    } finally {
      _isRefreshing = false;
    }
  }

  void searchLawyers(String query) {
    _searchQuery = query;
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
  }

  void filterBySpecialization(
    String? specialization,
  ) {
    _selectedSpecialization = specialization;
  }

  void filterByCity(String? city) {
    _selectedCity = city;
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _selectedSpecialization = null;
    _selectedCity = null;
  }

  Future<void> updateLawyerStatus(
    String lawyerId,
    String newStatus,
  ) async {
    state = state.map((lawyer) {
      if (lawyer.id == lawyerId) {
        return lawyer.copyWith(
          status: newStatus,
        );
      }

      return lawyer;
    }).toList();
  }

  Future<void> updateApprovalStatus(
    String lawyerId,
    bool approved,
  ) async {
    state = state.map((lawyer) {
      if (lawyer.id == lawyerId) {
        return lawyer.copyWith(
          isApproved: approved,
        );
      }

      return lawyer;
    }).toList();
  }

  Future<AdminLawyerModel?> getLawyerById(
    String lawyerId,
  ) async {
    final lawyer = await _service.getLawyerById(
      lawyerId,
    );

    if (lawyer != null) {
      return lawyer;
    }

    for (final item in state) {
      if (item.id == lawyerId) {
        return item;
      }
    }

    return null;
  }

  void clearError() {
    _clearError();
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void _clearError() {
    _error = null;
  }
}
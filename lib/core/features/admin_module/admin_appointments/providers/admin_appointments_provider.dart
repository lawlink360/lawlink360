import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawlink360/core/features/admin_module/admin_appointments/data/mock/admin_appointments_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/models/admin_appointment_model.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/models/appointment_status_model.dart';

final adminAppointmentsProvider = NotifierProvider<
    AdminAppointmentsNotifier,
    AsyncValue<List<AdminAppointmentModel>>>(
  AdminAppointmentsNotifier.new,
);

class AdminAppointmentsNotifier
    extends Notifier<AsyncValue<List<AdminAppointmentModel>>> {
  List<AdminAppointmentModel> _allAppointments = [];

  String _searchQuery = '';
  String? _selectedStatus;
  String? _selectedAppointmentType;
  String? _selectedPaymentStatus;

  String get searchQuery => _searchQuery;
  String? get selectedStatus => _selectedStatus;
  String? get selectedAppointmentType => _selectedAppointmentType;
  String? get selectedPaymentStatus => _selectedPaymentStatus;

  @override
  AsyncValue<List<AdminAppointmentModel>> build() {
    _allAppointments = List<AdminAppointmentModel>.from(
      AdminAppointmentsMockData.appointments,
    );

    return AsyncValue.data(
      List<AdminAppointmentModel>.from(_allAppointments),
    );
  }

  void search(String query) {
    _searchQuery = query.trim();
    _applyFilters();
  }

  void filterByStatus(String? status) {
    _selectedStatus = status;
    _applyFilters();
  }

  void filterByAppointmentType(String? type) {
    _selectedAppointmentType = type;
    _applyFilters();
  }

  void filterByPaymentStatus(String? status) {
    _selectedPaymentStatus = status;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedStatus = null;
    _selectedAppointmentType = null;
    _selectedPaymentStatus = null;

    _applyFilters();
  }

  void refresh() {
    state = const AsyncValue.loading();

    Future<void>.delayed(
      const Duration(milliseconds: 300),
      () {
        _allAppointments = List<AdminAppointmentModel>.from(
          AdminAppointmentsMockData.appointments,
        );

        _applyFilters();
      },
    );
  }

  void updateStatus(
    String appointmentId,
    String status,
  ) {
    final index = _allAppointments.indexWhere(
      (appointment) => appointment.id == appointmentId,
    );

    if (index == -1) return;

    _allAppointments[index] = _allAppointments[index].copyWith(
      status: status,
    );

    _applyFilters();
  }

  List<AdminAppointmentModel> get filteredAppointments {
    return _getFilteredAppointments();
  }

  int get totalCount => _allAppointments.length;

  int get pendingCount => _allAppointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatusModel.pending.value,
      )
      .length;

  int get confirmedCount => _allAppointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatusModel.confirmed.value,
      )
      .length;

  int get completedCount => _allAppointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatusModel.completed.value,
      )
      .length;

  int get cancelledCount => _allAppointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatusModel.cancelled.value,
      )
      .length;

  double get totalRevenue => _allAppointments
      .where(
        (appointment) =>
            appointment.paymentStatus.toLowerCase() == 'paid',
      )
      .fold(
        0,
        (total, appointment) => total + appointment.fee,
      );

  List<AdminAppointmentModel> _getFilteredAppointments() {
    Iterable<AdminAppointmentModel> results = _allAppointments;

    if (_selectedStatus != null && _selectedStatus!.isNotEmpty) {
      results = results.where(
        (appointment) => appointment.status == _selectedStatus,
      );
    }

    if (_selectedAppointmentType != null &&
        _selectedAppointmentType!.isNotEmpty) {
      results = results.where(
        (appointment) =>
            appointment.appointmentType == _selectedAppointmentType,
      );
    }

    if (_selectedPaymentStatus != null &&
        _selectedPaymentStatus!.isNotEmpty) {
      results = results.where(
        (appointment) =>
            appointment.paymentStatus == _selectedPaymentStatus,
      );
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();

      results = results.where(
        (appointment) =>
            appointment.clientName.toLowerCase().contains(query) ||
            appointment.clientEmail.toLowerCase().contains(query) ||
            appointment.clientPhone.toLowerCase().contains(query) ||
            appointment.lawyerName.toLowerCase().contains(query) ||
            appointment.lawyerId.toLowerCase().contains(query) ||
            appointment.clientId.toLowerCase().contains(query) ||
            appointment.caseTitle?.toLowerCase().contains(query) == true ||
            appointment.caseId?.toLowerCase().contains(query) == true,
      );
    }

    return List<AdminAppointmentModel>.from(results);
  }

  void _applyFilters() {
    state = AsyncValue.data(
      _getFilteredAppointments(),
    );
  }
}
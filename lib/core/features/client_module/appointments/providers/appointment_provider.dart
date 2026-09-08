import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/appointment_data.dart';
import '../models/appointment_model.dart';
import '../models/appointment_status.dart';

final appointmentProvider = NotifierProvider<
    AppointmentNotifier,
    AsyncValue<List<AppointmentModel>>>(
  AppointmentNotifier.new,
);

class AppointmentNotifier
    extends Notifier<AsyncValue<List<AppointmentModel>>> {
  List<AppointmentModel> _appointments = [];

  @override
  AsyncValue<List<AppointmentModel>> build() {
    _appointments = List<AppointmentModel>.from(
      AppointmentData.appointments,
    );

    return AsyncData(_appointments);
  }

  List<AppointmentModel> get appointments =>
      List<AppointmentModel>.unmodifiable(_appointments);

  int get totalAppointments => _appointments.length;

  int get upcomingCount => _appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.upcoming,
      )
      .length;

  int get todayCount => _appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.today,
      )
      .length;

  int get completedCount => _appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.completed,
      )
      .length;

  int get cancelledCount => _appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.cancelled,
      )
      .length;

  AppointmentModel? getAppointmentById(String appointmentId) {
    try {
      return _appointments.firstWhere(
        (appointment) =>
            appointment.appointmentId == appointmentId,
      );
    } catch (_) {
      return null;
    }
  }

  List<AppointmentModel> getByStatus(
    AppointmentStatus status,
  ) {
    return _appointments
        .where(
          (appointment) => appointment.status == status,
        )
        .toList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    await Future<void>.delayed(
      const Duration(milliseconds: 250),
    );

    _appointments = List<AppointmentModel>.from(
      AppointmentData.appointments,
    );

    state = AsyncData(_appointments);
  }

  void updateAppointments(
    List<AppointmentModel> appointments,
  ) {
    _appointments = List<AppointmentModel>.from(
      appointments,
    );

    state = AsyncData(_appointments);
  }
}

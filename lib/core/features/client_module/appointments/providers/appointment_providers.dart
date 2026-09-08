import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/appointment_model.dart';
import '../models/appointment_status.dart';
import 'appointment_provider.dart';

final allAppointmentsProvider =
    Provider<List<AppointmentModel>>((ref) {
  final appointmentState = ref.watch(appointmentProvider);

  return appointmentState.when(
    data: (appointments) => appointments,
    loading: () => const <AppointmentModel>[],
    error: (_, _) => const <AppointmentModel>[],
  );
});

final upcomingAppointmentsProvider =
    Provider<List<AppointmentModel>>((ref) {
  final appointments = ref.watch(allAppointmentsProvider);

  return appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.upcoming,
      )
      .toList();
});

final todayAppointmentsProvider =
    Provider<List<AppointmentModel>>((ref) {
  final appointments = ref.watch(allAppointmentsProvider);

  return appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.today,
      )
      .toList();
});

final completedAppointmentsProvider =
    Provider<List<AppointmentModel>>((ref) {
  final appointments = ref.watch(allAppointmentsProvider);

  return appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.completed,
      )
      .toList();
});

final cancelledAppointmentsProvider =
    Provider<List<AppointmentModel>>((ref) {
  final appointments = ref.watch(allAppointmentsProvider);

  return appointments
      .where(
        (appointment) =>
            appointment.status == AppointmentStatus.cancelled,
      )
      .toList();
});

final appointmentStatisticsProvider =
    Provider<AppointmentStatistics>((ref) {
  final appointments = ref.watch(allAppointmentsProvider);

  return AppointmentStatistics(
    total: appointments.length,
    upcoming: appointments
        .where(
          (appointment) =>
              appointment.status == AppointmentStatus.upcoming,
        )
        .length,
    today: appointments
        .where(
          (appointment) =>
              appointment.status == AppointmentStatus.today,
        )
        .length,
    completed: appointments
        .where(
          (appointment) =>
              appointment.status == AppointmentStatus.completed,
        )
        .length,
    cancelled: appointments
        .where(
          (appointment) =>
              appointment.status == AppointmentStatus.cancelled,
        )
        .length,
  );
});

class AppointmentStatistics {
  final int total;
  final int upcoming;
  final int today;
  final int completed;
  final int cancelled;

  const AppointmentStatistics({
    required this.total,
    required this.upcoming,
    required this.today,
    required this.completed,
    required this.cancelled,
  });
}

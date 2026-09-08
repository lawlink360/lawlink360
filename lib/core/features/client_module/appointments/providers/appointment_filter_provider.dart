import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/appointment_model.dart';
import '../models/appointment_status.dart';
import 'appointment_providers.dart';

enum AppointmentFilter {
  all,
  upcoming,
  today,
  completed,
  cancelled,
}

final appointmentFilterProvider =
    NotifierProvider<
        AppointmentFilterNotifier,
        AppointmentFilter>(
  AppointmentFilterNotifier.new,
);

class AppointmentFilterNotifier
    extends Notifier<AppointmentFilter> {
  @override
  AppointmentFilter build() {
    return AppointmentFilter.all;
  }

  void setFilter(AppointmentFilter filter) {
    state = filter;
  }

  void showAll() {
    state = AppointmentFilter.all;
  }

  void showUpcoming() {
    state = AppointmentFilter.upcoming;
  }

  void showToday() {
    state = AppointmentFilter.today;
  }

  void showCompleted() {
    state = AppointmentFilter.completed;
  }

  void showCancelled() {
    state = AppointmentFilter.cancelled;
  }
}

final filteredAppointmentsProvider =
    Provider<List<AppointmentModel>>((ref) {
  final appointments = ref.watch(allAppointmentsProvider);
  final filter = ref.watch(appointmentFilterProvider);

  switch (filter) {
    case AppointmentFilter.all:
      return appointments;

    case AppointmentFilter.upcoming:
      return appointments
          .where(
            (appointment) =>
                appointment.status ==
                AppointmentStatus.upcoming,
          )
          .toList();

    case AppointmentFilter.today:
      return appointments
          .where(
            (appointment) =>
                appointment.status ==
                AppointmentStatus.today,
          )
          .toList();

    case AppointmentFilter.completed:
      return appointments
          .where(
            (appointment) =>
                appointment.status ==
                AppointmentStatus.completed,
          )
          .toList();

    case AppointmentFilter.cancelled:
      return appointments
          .where(
            (appointment) =>
                appointment.status ==
                AppointmentStatus.cancelled,
          )
          .toList();
  }
});

import 'package:lawlink360/core/features/client_module/appointments/data/appointment_data.dart';
import 'package:lawlink360/core/features/client_module/appointments/models/appointment_model.dart';
import 'package:lawlink360/core/features/client_module/appointments/models/appointment_status.dart';

/// Read-only data access for appointments.
///
/// The current appointment data source is a static in-memory list
/// (`AppointmentData.appointments`). This repository wraps that source
/// so higher layers can depend on a single, explicit access point
/// without reading the data file directly.
///
/// No Firebase, Firestore, or remote data source is used at this stage.
/// This class is synchronous.
class AppointmentRepository {
  const AppointmentRepository();

  /// Returns a copy of the current appointment list.
  ///
  /// The returned list is a new list; mutating it does not affect
  /// the underlying data source.
  List<AppointmentModel> getAllAppointments() {
    return List<AppointmentModel>.from(
      AppointmentData.appointments,
    );
  }

  /// Returns the appointment with the given [appointmentId],
  /// or `null` when no such appointment exists.
  AppointmentModel? getAppointmentById(String appointmentId) {
    for (final appointment in AppointmentData.appointments) {
      if (appointment.appointmentId == appointmentId) {
        return appointment;
      }
    }
    return null;
  }

  /// Returns all appointments whose status is [status].
  List<AppointmentModel> getAppointmentsByStatus(
    AppointmentStatus status,
  ) {
    return AppointmentData.appointments
        .where((appointment) => appointment.status == status)
        .toList();
  }

  /// Returns the total number of appointments currently available.
  int getTotalCount() {
    return AppointmentData.appointments.length;
  }

  /// Returns the number of appointments matching [status].
  int getCountByStatus(AppointmentStatus status) {
    return AppointmentData.appointments
        .where((appointment) => appointment.status == status)
        .length;
  }
}
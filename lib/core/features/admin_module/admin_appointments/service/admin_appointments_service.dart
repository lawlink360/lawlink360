import 'package:lawlink360/core/features/admin_module/admin_appointments/data/mock/admin_appointments_mock_data.dart';
import 'package:lawlink360/core/features/admin_module/admin_appointments/models/admin_appointment_model.dart';

class AdminAppointmentsService {
  AdminAppointmentsService._();

  static final AdminAppointmentsService instance =
      AdminAppointmentsService._();

  Future<List<AdminAppointmentModel>> fetchAppointments() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<AdminAppointmentModel>.from(
      AdminAppointmentsMockData.appointments,
    );
  }

  Future<List<AdminAppointmentModel>> refreshAppointments() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return List<AdminAppointmentModel>.from(
      AdminAppointmentsMockData.appointments,
    );
  }

  Future<AdminAppointmentModel?> getAppointmentById(
    String appointmentId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    try {
      return AdminAppointmentsMockData.appointments.firstWhere(
        (appointment) => appointment.id == appointmentId,
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<AdminAppointmentModel>> searchAppointments(
    String query,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<AdminAppointmentModel>.from(
        AdminAppointmentsMockData.appointments,
      );
    }

    return AdminAppointmentsMockData.appointments.where(
      (appointment) {
        return appointment.clientName
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.clientEmail
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.clientPhone
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.clientId
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.lawyerName
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.lawyerId
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.lawyerSpecialization
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.appointmentType
                .toLowerCase()
                .contains(normalizedQuery) ||
            appointment.caseTitle
                    ?.toLowerCase()
                    .contains(normalizedQuery) ==
                true ||
            appointment.caseId
                    ?.toLowerCase()
                    .contains(normalizedQuery) ==
                true;
      },
    ).toList();
  }

  Future<List<AdminAppointmentModel>> filterByStatus(
    String status,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminAppointmentsMockData.appointments
        .where(
          (appointment) => appointment.status == status,
        )
        .toList();
  }

  Future<List<AdminAppointmentModel>> filterByAppointmentType(
    String appointmentType,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminAppointmentsMockData.appointments
        .where(
          (appointment) =>
              appointment.appointmentType == appointmentType,
        )
        .toList();
  }

  Future<List<AdminAppointmentModel>> filterByPaymentStatus(
    String paymentStatus,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminAppointmentsMockData.appointments
        .where(
          (appointment) =>
              appointment.paymentStatus == paymentStatus,
        )
        .toList();
  }

  Future<AdminAppointmentModel> updateAppointmentStatus({
    required AdminAppointmentModel appointment,
    required String status,
  }) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    return appointment.copyWith(
      status: status,
    );
  }

  Future<List<AdminAppointmentModel>> getAppointmentsByClient(
    String clientId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminAppointmentsMockData.appointments
        .where(
          (appointment) => appointment.clientId == clientId,
        )
        .toList();
  }

  Future<List<AdminAppointmentModel>> getAppointmentsByLawyer(
    String lawyerId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminAppointmentsMockData.appointments
        .where(
          (appointment) => appointment.lawyerId == lawyerId,
        )
        .toList();
  }

  Future<List<AdminAppointmentModel>> getAppointmentsByDate(
    DateTime date,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 200),
    );

    return AdminAppointmentsMockData.appointments
        .where(
          (appointment) =>
              appointment.appointmentDate.year == date.year &&
              appointment.appointmentDate.month == date.month &&
              appointment.appointmentDate.day == date.day,
        )
        .toList();
  }
}
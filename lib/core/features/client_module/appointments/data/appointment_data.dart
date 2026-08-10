import '../models/appointment_model.dart';
import '../models/appointment_status.dart';

class AppointmentData {
  static final List<AppointmentModel> appointments = [
    AppointmentModel(
      appointmentId: "APT-001",
      title: "Property Hearing",
      lawyerName: "Adv. Ahmad Khan",
      location: "Civil Court Lahore",
      dateTime: DateTime(2026, 8, 15, 10, 30),
      status: AppointmentStatus.upcoming,
    ),

    AppointmentModel(
      appointmentId: "APT-002",
      title: "Client Consultation",
      lawyerName: "Adv. Sarah Malik",
      location: "LawLink360 Video Call",
      dateTime: DateTime(2026, 8, 5, 14, 00),
      status: AppointmentStatus.today,
    ),

    AppointmentModel(
      appointmentId: "APT-003",
      title: "Family Court Hearing",
      lawyerName: "Adv. Bilal Ahmed",
      location: "Family Court Islamabad",
      dateTime: DateTime(2026, 7, 25, 9, 30),
      status: AppointmentStatus.completed,
    ),

    AppointmentModel(
      appointmentId: "APT-004",
      title: "Legal Consultation",
      lawyerName: "Adv. Imran Sheikh",
      location: "Law Office",
      dateTime: DateTime(2026, 7, 20, 11, 00),
      status: AppointmentStatus.cancelled,
    ),
  ];
}
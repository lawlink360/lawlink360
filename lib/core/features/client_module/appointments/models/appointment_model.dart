import 'appointment_status.dart';

class AppointmentModel {
  final String appointmentId;
  final String title;
  final String lawyerName;
  final String location;
  final DateTime dateTime;
  final AppointmentStatus status;

  const AppointmentModel({
    required this.appointmentId,
    required this.title,
    required this.lawyerName,
    required this.location,
    required this.dateTime,
    required this.status,
  });
}
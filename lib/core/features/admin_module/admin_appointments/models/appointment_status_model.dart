class AppointmentStatusModel {
  final String value;
  final String label;

  const AppointmentStatusModel({
    required this.value,
    required this.label,
  });

  static const pending = AppointmentStatusModel(
    value: 'pending',
    label: 'Pending',
  );

  static const confirmed = AppointmentStatusModel(
    value: 'confirmed',
    label: 'Confirmed',
  );

  static const completed = AppointmentStatusModel(
    value: 'completed',
    label: 'Completed',
  );

  static const cancelled = AppointmentStatusModel(
    value: 'cancelled',
    label: 'Cancelled',
  );

  static const noShow = AppointmentStatusModel(
    value: 'no_show',
    label: 'No Show',
  );

  static const List<AppointmentStatusModel> all = [
    pending,
    confirmed,
    completed,
    cancelled,
    noShow,
  ];

  static AppointmentStatusModel fromValue(String value) {
    return all.firstWhere(
      (status) => status.value == value,
      orElse: () => pending,
    );
  }

  bool get isPending => value == pending.value;

  bool get isConfirmed => value == confirmed.value;

  bool get isCompleted => value == completed.value;

  bool get isCancelled => value == cancelled.value;

  bool get isNoShow => value == noShow.value;
}
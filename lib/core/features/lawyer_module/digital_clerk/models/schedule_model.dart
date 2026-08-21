
class ScheduleModel {
  final String id;
  final String title;
  final String type;
  final String? clientId;
  final String? clientName;
  final String? caseId;
  final String? caseTitle;
  final String? location;
  final DateTime dateTime;
  final String? duration;
  final String notes;
  final bool reminderEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduleModel({
    required this.id,
    required this.title,
    required this.type,
    this.clientId,
    this.clientName,
    this.caseId,
    this.caseTitle,
    this.location,
    required this.dateTime,
    this.duration,
    required this.notes,
    required this.reminderEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  ScheduleModel copyWith({
    String? id,
    String? title,
    String? type,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    String? location,
    DateTime? dateTime,
    String? duration,
    String? notes,
    bool? reminderEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      location: location ?? this.location,
      dateTime: dateTime ?? this.dateTime,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


class TaskModel {
  final String id;
  final String title;
  final String description;
  final String priority;
  final String status;
  final String? clientId;
  final String? clientName;
  final String? caseId;
  final String? caseTitle;
  final DateTime? dueDate;
  final bool reminderEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    this.clientId,
    this.clientName,
    this.caseId,
    this.caseTitle,
    this.dueDate,
    required this.reminderEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? status,
    String? clientId,
    String? clientName,
    String? caseId,
    String? caseTitle,
    DateTime? dueDate,
    bool? reminderEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      caseId: caseId ?? this.caseId,
      caseTitle: caseTitle ?? this.caseTitle,
      dueDate: dueDate ?? this.dueDate,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

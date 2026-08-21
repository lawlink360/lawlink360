import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // ==========================================================
  // INITIALIZE
  // ==========================================================

  Future<void> initialize() async {
    // Initialize timezone database
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await requestPermission();
  }

  // ==========================================================
  // NOTIFICATION TAP
  // ==========================================================

  void _onNotificationTap(
    NotificationResponse response,
  ) {
    final payload = response.payload;

    if (payload == null || payload.isEmpty) {
      return;
    }

    // We will connect this to TaskDetailsScreen later.
  }

  // ==========================================================
  // REQUEST PERMISSION
  // ==========================================================

  Future<void> requestPermission() async {
    final androidImplementation =
        _notifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  // ==========================================================
  // SCHEDULE TASK REMINDER
  // ==========================================================

  Future<void> scheduleTaskReminder({
  required String taskId,
  required String taskTitle,
  required DateTime dueDate,
}) async {
  final scheduledDate = tz.TZDateTime(
    tz.local,
    dueDate.year,
    dueDate.month,
    dueDate.day,
    9,
    0,
  );

  // Don't schedule a reminder that is already in the past.
  if (scheduledDate.isBefore(
    tz.TZDateTime.now(tz.local),
  )) {
    return;
  }

  await _notifications.zonedSchedule(
    taskId.hashCode,
    'Task Reminder',
    taskTitle,
    scheduledDate,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_reminders',
        'Task Reminders',
        channelDescription:
            'Reminders for Digital Clerk tasks',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode:
        AndroidScheduleMode.exactAllowWhileIdle,
    payload: taskId,
  );
}
  // ==========================================================
  // CANCEL TASK REMINDER
  // ==========================================================

  Future<void> cancelTaskReminder(
    String taskId,
  ) async {
    await _notifications.cancel(
      taskId.hashCode,
    );
  }

  // ==========================================================
  // RESCHEDULE TASK REMINDER
  // ==========================================================

  Future<void> rescheduleTaskReminder({
    required String taskId,
    required String taskTitle,
    required DateTime dueDate,
  }) async {
    await cancelTaskReminder(taskId);

    await scheduleTaskReminder(
      taskId: taskId,
      taskTitle: taskTitle,
      dueDate: dueDate,
    );
  }
}
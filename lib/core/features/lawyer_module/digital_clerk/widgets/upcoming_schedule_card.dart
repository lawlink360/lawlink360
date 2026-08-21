import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/schedule_model.dart';
import '../providers/clerk_providers.dart';
import '../screens/add_schedule_screen.dart';

class UpcomingScheduleCard extends ConsumerWidget {
  const UpcomingScheduleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(clerkSchedulesProvider);

    final now = DateTime.now();

    final upcomingSchedules = schedules.where((schedule) {
      final isUpcoming = schedule.dateTime.isAfter(now);

      final type = schedule.type.toLowerCase();

      final isAppointment = type == 'appointment';
      final isReminder = type == 'reminder';

      return isUpcoming && (isAppointment || isReminder);
    }).toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // HEADER
          // ======================================================
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.event_note_outlined,
                  color: Color(0xFFD4AF37),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Schedule',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13294B),
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Your upcoming meetings and events',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      // We will connect this to the full schedule screen later.
                    },
                    child: const Text(
                      'View Schedule',
                      style: TextStyle(
                        color: Color(0xFF13294B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddScheduleScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, size: 17),
                    label: const Text('Add Schedule'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF13294B),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ======================================================
          // EMPTY STATE
          // ======================================================
          if (upcomingSchedules.isEmpty)
            const _EmptyScheduleState()
          // ======================================================
          // SCHEDULE LIST
          // ======================================================
          else ...[
            ...upcomingSchedules
                .take(3)
                .map((schedule) => _ScheduleItem(schedule: schedule)),

            const SizedBox(height: 6),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  // We will connect this to Add Schedule later.
                },
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text(
                  'Add Schedule',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF13294B),
                  side: const BorderSide(color: Color(0xFFD4AF37)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ======================================================
// EMPTY STATE
// ======================================================

class _EmptyScheduleState extends StatelessWidget {
  const _EmptyScheduleState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 38,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'No upcoming schedule',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Your upcoming events will appear here.',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// SCHEDULE ITEM
// ======================================================

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({required this.schedule});

  final ScheduleModel schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          // ======================================================
          // ICON
          // ======================================================
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF13294B).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _scheduleIcon(),
              color: const Color(0xFF13294B),
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          // ======================================================
          // DETAILS
          // ======================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  _buildSubtitle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ======================================================
          // DATE & TIME
          // ======================================================
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDate(schedule.dateTime),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFD4AF37),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                _formatTime(schedule.dateTime),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13294B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ======================================================
  // SUBTITLE
  // ======================================================

  String _buildSubtitle() {
    if (schedule.caseTitle != null && schedule.caseTitle!.trim().isNotEmpty) {
      return schedule.caseTitle!;
    }

    if (schedule.clientName != null && schedule.clientName!.trim().isNotEmpty) {
      return schedule.clientName!;
    }

    if (schedule.location != null && schedule.location!.trim().isNotEmpty) {
      return schedule.location!;
    }

    return schedule.type;
  }

  // ======================================================
  // DATE
  // ======================================================

  String _formatDate(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final scheduleDate = DateTime(date.year, date.month, date.day);

    final difference = scheduleDate.difference(today).inDays;

    if (difference == 0) {
      return 'Today';
    }

    if (difference == 1) {
      return 'Tomorrow';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // ======================================================
  // TIME
  // ======================================================

  String _formatTime(DateTime date) {
    final hour = date.hour;
    final minute = date.minute;

    final period = hour >= 12 ? 'PM' : 'AM';

    final displayHour = hour % 12 == 0 ? 12 : hour % 12;

    return '$displayHour:'
        '${minute.toString().padLeft(2, '0')} '
        '$period';
  }

  // ======================================================
  // ICON
  // ======================================================

  IconData _scheduleIcon() {
    switch (schedule.type.toLowerCase()) {
      case 'court':
        return Icons.gavel_outlined;

      case 'meeting':
        return Icons.people_outline;

      case 'call':
        return Icons.phone_outlined;

      case 'appointment':
        return Icons.event_outlined;

      default:
        return Icons.event_note_outlined;
    }
  }
}

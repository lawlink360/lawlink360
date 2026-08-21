import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import '../providers/clerk_providers.dart';
import 'add_task_screen.dart';

class TaskDetailsScreen extends ConsumerWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the latest version of this task from the provider
    final currentTask = ref.watch(
      clerkTasksProvider.select(
        (tasks) =>
            tasks.firstWhere((item) => item.id == task.id, orElse: () => task),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Task Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TaskHeaderCard(task: currentTask),

            const SizedBox(height: 16),

            _SectionCard(
              title: 'Task Information',
              icon: Icons.task_alt_outlined,
              children: [
                _DetailRow(label: 'Title', value: currentTask.title),
                _DetailRow(label: 'Priority', value: currentTask.priority),
                _DetailRow(label: 'Status', value: currentTask.status),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Related Information',
              icon: Icons.folder_outlined,
              children: [
                if (currentTask.clientName != null &&
                    currentTask.clientName!.trim().isNotEmpty)
                  _DetailRow(label: 'Client', value: currentTask.clientName!),

                if (currentTask.caseTitle != null &&
                    currentTask.caseTitle!.trim().isNotEmpty)
                  _DetailRow(label: 'Case', value: currentTask.caseTitle!),

                if ((currentTask.clientName == null ||
                        currentTask.clientName!.trim().isEmpty) &&
                    (currentTask.caseTitle == null ||
                        currentTask.caseTitle!.trim().isEmpty))
                  Text(
                    'No client or case linked.',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Schedule',
              icon: Icons.event_outlined,
              children: [
                _DetailRow(
                  label: 'Due Date',
                  value: _formatDate(currentTask.dueDate),
                ),
                _DetailRow(
                  label: 'Reminder',
                  value: currentTask.reminderEnabled ? 'Enabled' : 'Disabled',
                ),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Description',
              icon: Icons.notes_outlined,
              children: [
                Text(
                  currentTask.description.isEmpty
                      ? 'No description added.'
                      : currentTask.description,
                  style: TextStyle(
                    color: currentTask.description.isEmpty
                        ? Colors.grey.shade500
                        : const Color(0xFF13294B),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            _SectionCard(
              title: 'Task History',
              icon: Icons.history_outlined,
              children: [
                _DetailRow(
                  label: 'Created',
                  value: _formatDateTime(currentTask.createdAt),
                ),
                _DetailRow(
                  label: 'Updated',
                  value: _formatDateTime(currentTask.updatedAt),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ==================================================
            // ACTION BUTTONS
            // ==================================================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _markCompleted(context, ref);
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Mark as Completed',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddTaskScreen(taskToEdit: task),
                    ),
                  );

                  if (!context.mounted) {
                    return;
                  }

                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(result),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.edit_outlined),
                label: const Text(
                  'Edit Task',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF13294B),
                  side: const BorderSide(color: Color(0xFF13294B)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _deleteTask(context, ref);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFD32F2F),
                ),
                label: const Text(
                  'Delete Task',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD32F2F)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // MARK COMPLETED
  // ==========================================================

  void _markCompleted(BuildContext context, WidgetRef ref) {
    // Get the latest version of the task
    final currentTask = ref.read(
      clerkTasksProvider.select(
        (tasks) =>
            tasks.firstWhere((item) => item.id == task.id, orElse: () => task),
      ),
    );

    final updatedTask = currentTask.copyWith(
      status: 'Completed',
      updatedAt: DateTime.now(),
    );

    ref.read(clerkTasksProvider.notifier).updateTask(updatedTask);

    if (context.mounted) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task marked as completed.')),
      );
    }
  }

  // ==========================================================
  // DELETE TASK
  // ==========================================================

  Future<void> _deleteTask(BuildContext context, WidgetRef ref) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Task?',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this task? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF13294B)),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    ref.read(clerkTasksProvider.notifier).removeTask(task.id);

    if (context.mounted) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task deleted successfully.')),
      );
    }
  }

  // ==========================================================
  // DATE FORMAT
  // ==========================================================

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Not provided';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }
}

// ============================================================
// TASK HEADER
// ============================================================

class _TaskHeaderCard extends StatelessWidget {
  const _TaskHeaderCard({required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF13294B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.checklist_rounded,
              color: Color(0xFFD4AF37),
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  task.clientName ?? task.caseTitle ?? 'General Task',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          _StatusBadge(status: task.status),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION CARD
// ============================================================

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF13294B), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ...children,
        ],
      ),
    );
  }
}

// ============================================================
// DETAIL ROW
// ============================================================

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF13294B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _statusColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFFB74D);

      case 'in progress':
        return const Color(0xFF42A5F5);

      case 'completed':
        return const Color(0xFF66BB6A);

      case 'cancelled':
        return const Color(0xFFD32F2F);

      default:
        return const Color(0xFFD4AF37);
    }
  }
}

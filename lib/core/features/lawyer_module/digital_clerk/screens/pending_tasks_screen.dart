import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import '../providers/clerk_providers.dart';
import 'add_task_screen.dart';

class PendingTasksScreen extends ConsumerWidget {
  const PendingTasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(clerkTasksProvider);

    final pendingTasks = tasks.where((task) {
      return task.status == 'Pending';
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: const Text(
          'Pending Tasks',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF13294B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF13294B),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF13294B),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTaskScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),

      body: pendingTasks.isEmpty
          ? _emptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                16,
                20,
                16,
                100,
              ),
              itemCount: pendingTasks.length,
              itemBuilder: (context, index) {
                final task = pendingTasks[index];

                return _taskCard(
                  context,
                  ref,
                  task,
                );
              },
            ),
    );
  }

  // ============================================================
  // TASK CARD
  // ============================================================

  Widget _taskCard(
    BuildContext context,
    WidgetRef ref,
    TaskModel task,
  ) {
    final priorityColor = _priorityColor(task.priority);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          _openEditTask(
            context,
            task,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================================================
              // TITLE + PRIORITY
              // ==================================================

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF13294B),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  _priorityBadge(
                    task.priority,
                    priorityColor,
                  ),
                ],
              ),

              // ==================================================
              // DESCRIPTION
              // ==================================================

              if (task.description.trim().isNotEmpty) ...[
                const SizedBox(height: 8),

                Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],

              const SizedBox(height: 14),

              // ==================================================
              // CLIENT
              // ==================================================

              if (task.clientName != null &&
                  task.clientName!.trim().isNotEmpty)
                _infoRow(
                  icon: Icons.person_outline,
                  text: task.clientName!,
                ),

              // ==================================================
              // CASE
              // ==================================================

              if (task.caseTitle != null &&
                  task.caseTitle!.trim().isNotEmpty)
                _infoRow(
                  icon: Icons.folder_outlined,
                  text: task.caseTitle!,
                ),

              // ==================================================
              // DUE DATE
              // ==================================================

              if (task.dueDate != null)
                _infoRow(
                  icon: Icons.calendar_today_outlined,
                  text: 'Due ${_formatDate(task.dueDate!)}',
                ),

              const SizedBox(height: 14),

              // ==================================================
              // BOTTOM ACTION ROW
              // ==================================================

              Row(
                children: [
                  _statusBadge(
                    task.status,
                  ),

                  const Spacer(),

                  IconButton(
                    tooltip: 'Edit Task',
                    onPressed: () {
                      _openEditTask(
                        context,
                        task,
                      );
                    },
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF13294B),
                    ),
                  ),

                  IconButton(
                    tooltip: 'Delete Task',
                    onPressed: () {
                      _confirmDelete(
                        context,
                        ref,
                        task,
                      );
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // OPEN EDIT TASK
  // ============================================================

  Future<void> _openEditTask(
    BuildContext context,
    TaskModel task,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(
          taskToEdit: task,
        ),
      ),
    );

    // The screen automatically rebuilds because it watches
    // clerkTasksProvider.
  }

  // ============================================================
  // DELETE CONFIRMATION
  // ============================================================

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    TaskModel task,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Task?',
          ),
          content: Text(
            'Are you sure you want to delete "${task.title}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    ref
        .read(clerkTasksProvider.notifier)
        .removeTask(task.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Task deleted successfully.',
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _emptyState(
    BuildContext context,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withValues(
                  alpha: 0.12,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.task_alt_outlined,
                size: 46,
                color: Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Pending Tasks',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF13294B),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'You currently have no pending tasks.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddTaskScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                'Add Task',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF13294B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PRIORITY BADGE
  // ============================================================

  Widget _priorityBadge(
    String priority,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.10,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _statusBadge(
    String status,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF13294B).withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Color(0xFF13294B),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ============================================================
  // INFO ROW
  // ============================================================

  Widget _infoRow({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 7,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xFF13294B),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRIORITY COLOR
  // ============================================================

  Color _priorityColor(
    String priority,
  ) {
    switch (priority) {
      case 'Low':
        return Colors.green.shade700;

      case 'Medium':
        return Colors.orange.shade700;

      case 'High':
        return Colors.deepOrange.shade700;

      case 'Urgent':
        return Colors.red.shade700;

      default:
        return const Color(0xFF13294B);
    }
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(
    DateTime date,
  ) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import '../models/client_model.dart';
import '../models/case_model.dart';
import '../providers/clerk_providers.dart';
import 'package:lawlink360/core/services/notification_service.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key, this.taskToEdit});

  final TaskModel? taskToEdit;

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _priority = 'Medium';
  String _status = 'Pending';

  DateTime? _dueDate;
  bool _reminderEnabled = false;

  ClientModel? _selectedClient;
  CaseModel? _selectedCase;

  @override
  void initState() {
    super.initState();

    final existingTask = widget.taskToEdit;

    if (existingTask != null) {
      _titleController.text = existingTask.title;
      _descriptionController.text = existingTask.description;

      _priority = existingTask.priority;
      _status = existingTask.status;
      _dueDate = existingTask.dueDate;
      _reminderEnabled = existingTask.reminderEnabled;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _loadRelatedObjects(List<ClientModel> clients, List<CaseModel> cases) {
    final existingTask = widget.taskToEdit;

    if (existingTask == null) {
      return;
    }

    if (_selectedClient == null && existingTask.clientId != null) {
      for (final client in clients) {
        if (client.id == existingTask.clientId) {
          _selectedClient = client;
          break;
        }
      }
    }

    if (_selectedCase == null && existingTask.caseId != null) {
      for (final caseItem in cases) {
        if (caseItem.id == existingTask.caseId) {
          _selectedCase = caseItem;
          break;
        }
      }
    }
  }

  // ======================================================
  // DATE PICKER
  // ======================================================

  Future<void> _selectDueDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _dueDate = selectedDate;
      });
    }
  }

  // ======================================================
  // SAVE TASK
  // ======================================================

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();
    final existingTask = widget.taskToEdit;

    final task = TaskModel(
      id: existingTask?.id ?? 'task_${now.microsecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      priority: _priority,
      status: _status,
      clientId: _selectedClient?.id,
      clientName: _selectedClient?.name,
      caseId: _selectedCase?.id,
      caseTitle: _selectedCase?.caseTitle,
      dueDate: _dueDate,
      reminderEnabled: _reminderEnabled,
      createdAt: existingTask?.createdAt ?? now,
      updatedAt: now,
    );

    // ==========================================================
    // SAVE / UPDATE TASK
    // ==========================================================

    if (existingTask == null) {
      ref.read(clerkTasksProvider.notifier).addTask(task);
    } else {
      ref.read(clerkTasksProvider.notifier).updateTask(task);
    }

    if (!mounted) {
      return;
    }

    // ==========================================================
    // SHOW SUCCESS MESSAGE
    // ==========================================================

    Navigator.pop(
      context,
      existingTask == null
          ? 'Task added successfully.'
          : 'Task updated successfully.',
    );

    // ==========================================================
    // CLOSE SCREEN
    // ==========================================================

    Navigator.pop(context, true);

    // ==========================================================
    // TASK REMINDER
    // ==========================================================
    //
    // Reminder handling happens after the task screen closes.
    // It must not prevent the update UI from completing.
    //

    try {
      if (_reminderEnabled && _dueDate != null) {
        await NotificationService.instance.rescheduleTaskReminder(
          taskId: task.id,
          taskTitle: task.title,
          dueDate: task.dueDate!,
        );
      } else {
        await NotificationService.instance.cancelTaskReminder(task.id);
      }
    } catch (e) {
      debugPrint('Task reminder update failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clerkClientsProvider);
    final cases = ref.watch(clerkCasesProvider);

    _loadRelatedObjects(clients, cases);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        title: Text(
          widget.taskToEdit == null ? 'Add Task' : 'Edit Task',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF13294B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF13294B)),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          children: [
            // ======================================================
            // TASK INFORMATION
            // ======================================================
            _sectionTitle(
              icon: Icons.task_alt_outlined,
              title: 'Task Information',
            ),

            const SizedBox(height: 12),

            _textField(
              controller: _titleController,
              label: 'Task Title',
              hint: 'Enter task title',
              icon: Icons.task_outlined,
              required: true,
            ),

            _textField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Describe what needs to be done',
              icon: Icons.notes_outlined,
              maxLines: 4,
            ),

            // ======================================================
            // PRIORITY
            // ======================================================
            _dropdownField(
              label: 'Priority',
              value: _priority,
              items: const ['Low', 'Medium', 'High', 'Urgent'],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _priority = value;
                  });
                }
              },
            ),

            // ======================================================
            // STATUS
            // ======================================================
            _dropdownField(
              label: 'Status',
              value: _status,
              items: const ['Pending', 'In Progress', 'Completed', 'Cancelled'],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _status = value;
                  });
                }
              },
            ),

            const SizedBox(height: 8),

            // ======================================================
            // CLIENT
            // ======================================================
            _sectionTitle(icon: Icons.person_outline, title: 'Related Client'),

            const SizedBox(height: 12),

            _clientSelector(clients: clients),

            const SizedBox(height: 4),

            // ======================================================
            // CASE
            // ======================================================
            _sectionTitle(icon: Icons.folder_outlined, title: 'Related Case'),

            const SizedBox(height: 12),

            _caseSelector(cases: cases),

            const SizedBox(height: 8),

            // ======================================================
            // DUE DATE
            // ======================================================
            _sectionTitle(
              icon: Icons.calendar_today_outlined,
              title: 'Schedule',
            ),

            const SizedBox(height: 12),

            _dateField(),

            const SizedBox(height: 12),

            // ======================================================
            // REMINDER
            // ======================================================
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: SwitchListTile(
                value: _reminderEnabled,
                onChanged: (value) {
                  setState(() {
                    _reminderEnabled = value;
                  });
                },
                activeThumbColor: const Color(0xFFD4AF37),
                title: const Text(
                  'Enable Reminder',
                  style: TextStyle(
                    color: Color(0xFF13294B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Remind me about this task',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                secondary: const Icon(
                  Icons.notifications_active_outlined,
                  color: Color(0xFF13294B),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ======================================================
            // SAVE BUTTON
            // ======================================================
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _saveTask,
                icon: const Icon(Icons.save_outlined),
                label: Text(
                  widget.taskToEdit == null ? 'Save Task' : 'Update Task',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13294B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================
  // SECTION TITLE
  // ======================================================

  Widget _sectionTitle({required IconData icon, required String title}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFFD4AF37)),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF13294B),
          ),
        ),
      ],
    );
  }

  // ======================================================
  // TEXT FIELD
  // ======================================================

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: const Color(0xFF13294B)),
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 1.5),
          ),
        ),

        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }

                return null;
              }
            : null,
      ),
    );
  }

  // ======================================================
  // DROPDOWN
  // ======================================================

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,

        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.tune_outlined, color: Color(0xFF13294B)),
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),

        items: items.map((item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),

        onChanged: onChanged,
      ),
    );
  }

  // ======================================================
  // CLIENT SELECTOR
  // ======================================================

  Widget _clientSelector({required List<ClientModel> clients}) {
    return DropdownButtonFormField<ClientModel>(
      initialValue: _selectedClient,

      decoration: InputDecoration(
        labelText: 'Client',
        hintText: 'Select client (optional)',
        prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF13294B)),
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),

      items: clients.map((client) {
        return DropdownMenuItem<ClientModel>(
          value: client,
          child: Text(client.name),
        );
      }).toList(),

      onChanged: (client) {
        setState(() {
          _selectedClient = client;
        });
      },
    );
  }

  // ======================================================
  // CASE SELECTOR
  // ======================================================

  Widget _caseSelector({required List<CaseModel> cases}) {
    return DropdownButtonFormField<CaseModel>(
      initialValue: _selectedCase,

      decoration: InputDecoration(
        labelText: 'Case',
        hintText: 'Select case (optional)',
        prefixIcon: const Icon(Icons.folder_outlined, color: Color(0xFF13294B)),
        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),

      items: cases.map((caseItem) {
        return DropdownMenuItem<CaseModel>(
          value: caseItem,
          child: Text(
            caseItem.caseTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),

      onChanged: (caseItem) {
        setState(() {
          _selectedCase = caseItem;
        });
      },
    );
  }

  // ======================================================
  // DATE FIELD
  // ======================================================

  Widget _dateField() {
    return InkWell(
      onTap: _selectDueDate,
      borderRadius: BorderRadius.circular(14),

      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Due Date',
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: Color(0xFF13294B),
          ),
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
        ),

        child: Text(
          _dueDate == null
              ? 'Select due date'
              : '${_dueDate!.day.toString().padLeft(2, '0')}/'
                    '${_dueDate!.month.toString().padLeft(2, '0')}/'
                    '${_dueDate!.year}',

          style: TextStyle(
            color: _dueDate == null
                ? Colors.grey.shade600
                : const Color(0xFF1F2937),
          ),
        ),
      ),
    );
  }
}

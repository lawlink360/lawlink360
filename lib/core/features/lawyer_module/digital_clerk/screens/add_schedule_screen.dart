import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/schedule_model.dart';
import '../providers/clerk_providers.dart';

class AddScheduleScreen extends ConsumerStatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  ConsumerState<AddScheduleScreen> createState() =>
      _AddScheduleScreenState();
}

class _AddScheduleScreenState
    extends ConsumerState<AddScheduleScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _clientController = TextEditingController();
  final _caseController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedType = 'Appointment';

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  bool _reminderEnabled = false;

  final List<String> _scheduleTypes = const [
    'Appointment',
    'Reminder',
    'Meeting',
    'Court Event',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _clientController.dispose();
    _caseController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> _selectDate() async {
    final now = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // ============================================================
  // TIME PICKER
  // ============================================================

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // ============================================================
  // SAVE SCHEDULE
  // ============================================================

  void _saveSchedule() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDate == null) {
      _showMessage('Please select a date.');
      return;
    }

    if (_selectedTime == null) {
      _showMessage('Please select a time.');
      return;
    }

    final dateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    final now = DateTime.now();

    final schedule = ScheduleModel(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      title: _titleController.text.trim(),
      type: _selectedType,
      clientId: null,
      clientName: _clientController.text.trim().isEmpty
          ? null
          : _clientController.text.trim(),
      caseId: null,
      caseTitle: _caseController.text.trim().isEmpty
          ? null
          : _caseController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      dateTime: dateTime,
      duration: _durationController.text.trim().isEmpty
          ? null
          : _durationController.text.trim(),
      notes: _notesController.text.trim(),
      reminderEnabled: _reminderEnabled,
      createdAt: now,
      updatedAt: now,
    );

    ref
        .read(clerkSchedulesProvider.notifier)
        .addSchedule(schedule);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Schedule added successfully.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF13294B),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Schedule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              30,
            ),
            children: [

              // ==================================================
              // HEADER
              // ==================================================

              const Text(
                'Create Schedule',
                style: TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Add an appointment, reminder, meeting, court event or other scheduled event.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // SCHEDULE TYPE
              // ==================================================

              const Text(
                'Schedule Type',
                style: TextStyle(
                  color: Color(0xFF13294B),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedType,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    items: _scheduleTypes
                        .map(
                          (type) => DropdownMenuItem<String>(
                            value: type,
                            child: Row(
                              children: [
                                Icon(
                                  _typeIcon(type),
                                  size: 20,
                                  color:
                                      const Color(0xFFD4AF37),
                                ),
                                const SizedBox(width: 10),
                                Text(type),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // TITLE
              // ==================================================

              _fieldLabel('Title'),

              const SizedBox(height: 8),

              TextFormField(
                controller: _titleController,
                textCapitalization:
                    TextCapitalization.sentences,
                decoration: _inputDecoration(
                  hint: 'Enter schedule title',
                  icon: Icons.title_outlined,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter a title.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // ==================================================
              // DATE + TIME
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: _dateButton(),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _timeButton(),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ==================================================
              // CLIENT
              // ==================================================

              _fieldLabel('Client (Optional)'),

              const SizedBox(height: 8),

              TextFormField(
                controller: _clientController,
                textCapitalization:
                    TextCapitalization.words,
                decoration: _inputDecoration(
                  hint: 'Client name',
                  icon: Icons.person_outline_rounded,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // CASE
              // ==================================================

              _fieldLabel('Case (Optional)'),

              const SizedBox(height: 8),

              TextFormField(
                controller: _caseController,
                textCapitalization:
                    TextCapitalization.sentences,
                decoration: _inputDecoration(
                  hint: 'Case title',
                  icon: Icons.folder_outlined,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // LOCATION
              // ==================================================

              _fieldLabel('Location (Optional)'),

              const SizedBox(height: 8),

              TextFormField(
                controller: _locationController,
                textCapitalization:
                    TextCapitalization.sentences,
                decoration: _inputDecoration(
                  hint: 'Court, office, online, etc.',
                  icon: Icons.location_on_outlined,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // DURATION
              // ==================================================

              _fieldLabel('Duration (Optional)'),

              const SizedBox(height: 8),

              TextFormField(
                controller: _durationController,
                decoration: _inputDecoration(
                  hint: 'e.g. 30 minutes',
                  icon: Icons.timer_outlined,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // NOTES
              // ==================================================

              _fieldLabel('Notes'),

              const SizedBox(height: 8),

              TextFormField(
                controller: _notesController,
                textCapitalization:
                    TextCapitalization.sentences,
                maxLines: 4,
                decoration: _inputDecoration(
                  hint: 'Add notes or additional details',
                  icon: Icons.notes_outlined,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // REMINDER
              // ==================================================

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Enable Reminder',
                    style: TextStyle(
                      color: Color(0xFF13294B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Enable a reminder for this schedule',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                  value: _reminderEnabled,
                  activeThumbColor:
                      const Color(0xFFD4AF37),
                  onChanged: (value) {
                    setState(() {
                      _reminderEnabled = value;
                    });
                  },
                ),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // SAVE
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _saveSchedule,
                  icon: const Icon(
                    Icons.check_rounded,
                  ),
                  label: const Text(
                    'Save Schedule',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF13294B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DATE BUTTON
  // ============================================================

  Widget _dateButton() {
    return InkWell(
      onTap: _selectDate,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 19,
              color: Color(0xFFD4AF37),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                _selectedDate == null
                    ? 'Date'
                    : _formatDate(_selectedDate!),
                style: TextStyle(
                  fontSize: 13,
                  color: _selectedDate == null
                      ? Colors.grey
                      : const Color(0xFF13294B),
                  fontWeight: _selectedDate == null
                      ? FontWeight.normal
                      : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TIME BUTTON
  // ============================================================

  Widget _timeButton() {
    return InkWell(
      onTap: _selectTime,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              size: 20,
              color: Color(0xFFD4AF37),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                _selectedTime == null
                    ? 'Time'
                    : _formatTime(_selectedTime!),
                style: TextStyle(
                  fontSize: 13,
                  color: _selectedTime == null
                      ? Colors.grey
                      : const Color(0xFF13294B),
                  fontWeight: _selectedTime == null
                      ? FontWeight.normal
                      : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FIELD LABEL
  // ============================================================

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF13294B),
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF13294B),
        size: 20,
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 13,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE5E7EB),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFD4AF37),
          width: 1.4,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
    );
  }

  // ============================================================
  // TYPE ICON
  // ============================================================

  IconData _typeIcon(String type) {
    switch (type) {
      case 'Appointment':
        return Icons.event_outlined;

      case 'Reminder':
        return Icons.notifications_active_outlined;

      case 'Meeting':
        return Icons.people_outline;

      case 'Court Event':
        return Icons.gavel_outlined;

      default:
        return Icons.event_note_outlined;
    }
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // ============================================================
  // TIME FORMAT
  // ============================================================

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod;

    final minute =
        time.minute.toString().padLeft(2, '0');

    final period =
        time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }
}
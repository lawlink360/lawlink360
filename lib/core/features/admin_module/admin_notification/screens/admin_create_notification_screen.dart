import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/admin_notification_model.dart';
import '../providers/admin_notifications_provider.dart';

class AdminCreateNotificationScreen extends ConsumerStatefulWidget {
  const AdminCreateNotificationScreen({super.key});

  @override
  ConsumerState<AdminCreateNotificationScreen> createState() =>
      _AdminCreateNotificationScreenState();
}

class _AdminCreateNotificationScreenState
    extends ConsumerState<AdminCreateNotificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  String _type = 'System';
  String _recipientType = 'All';
  String _priority = 'Normal';
  String _sendMode = 'Now';

  DateTime? _scheduledAt;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      initialDate: _scheduledAt ?? now,
    );

    if (selectedDate == null || !mounted) {
      return;
    }

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _scheduledAt != null
          ? TimeOfDay.fromDateTime(_scheduledAt!)
          : TimeOfDay.now(),
    );

    if (selectedTime == null || !mounted) {
      return;
    }

    setState(() {
      _scheduledAt = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_sendMode == 'Schedule' && _scheduledAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a date and time.'),
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    if (!mounted) {
      return;
    }

    final now = DateTime.now();

    final status = switch (_sendMode) {
      'Now' => 'Sent',
      'Schedule' => 'Scheduled',
      _ => 'Draft',
    };

    final notification = AdminNotificationModel(
      id: 'notification_${now.millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      message: _messageController.text.trim(),
      type: _type,
      recipientType: _recipientType,
      recipientId: null,
      recipientName: null,
      recipientEmail: null,
      priority: _priority,
      status: status,
      isRead: false,
      scheduledAt: _sendMode == 'Schedule'
          ? _scheduledAt
          : null,
      sentAt: _sendMode == 'Now' ? now : null,
      readAt: null,
      createdAt: now,
      updatedAt: now,
    );

    ref
        .read(adminNotificationsProvider.notifier)
        .addNotification(notification);

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          switch (_sendMode) {
            'Now' => 'Notification sent successfully.',
            'Schedule' => 'Notification scheduled successfully.',
            _ => 'Notification saved as draft.',
          },
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Notification'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroCard(),
              const SizedBox(height: 20),
              _buildMessageSection(),
              const SizedBox(height: 20),
              _buildDeliverySection(),
              const SizedBox(height: 20),
              _buildScheduleSection(),
              const SizedBox(height: 28),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context)
            .colorScheme
            .primary
            .withValues(alpha: 0.08),
        border: Border.all(
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a notification',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Send an important message to users, lawyers, or everyone on LawLink360.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageSection() {
    return _SectionCard(
      title: 'Notification Content',
      icon: Icons.edit_note_outlined,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            maxLength: 100,
            decoration: const InputDecoration(
              labelText: 'Notification title',
              hintText: 'Enter notification title',
              prefixIcon: Icon(Icons.title_outlined),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title.';
              }

              if (value.trim().length < 3) {
                return 'Title must be at least 3 characters.';
              }

              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            maxLength: 500,
            decoration: const InputDecoration(
              labelText: 'Message',
              hintText: 'Write the notification message...',
              prefixIcon: Icon(Icons.message_outlined),
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a message.';
              }

              if (value.trim().length < 5) {
                return 'Message must be at least 5 characters.';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverySection() {
    return _SectionCard(
      title: 'Delivery Settings',
      icon: Icons.send_outlined,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            initialValue: _type,
            decoration: const InputDecoration(
              labelText: 'Notification type',
              prefixIcon: Icon(
                Icons.category_outlined,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Appointment',
                child: Text('Appointment'),
              ),
              DropdownMenuItem(
                value: 'Payment',
                child: Text('Payment'),
              ),
              DropdownMenuItem(
                value: 'Verification',
                child: Text('Verification'),
              ),
              DropdownMenuItem(
                value: 'Case',
                child: Text('Case'),
              ),
              DropdownMenuItem(
                value: 'Account',
                child: Text('Account'),
              ),
              DropdownMenuItem(
                value: 'System',
                child: Text('System'),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _type = value;
              });
            },
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _recipientType,
            decoration: const InputDecoration(
              labelText: 'Recipient',
              prefixIcon: Icon(
                Icons.groups_outlined,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'User',
                child: Text('Users'),
              ),
              DropdownMenuItem(
                value: 'Lawyer',
                child: Text('Lawyers'),
              ),
              DropdownMenuItem(
                value: 'All',
                child: Text('Everyone'),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _recipientType = value;
              });
            },
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _priority,
            decoration: const InputDecoration(
              labelText: 'Priority',
              prefixIcon: Icon(
                Icons.flag_outlined,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'High',
                child: Text('High'),
              ),
              DropdownMenuItem(
                value: 'Normal',
                child: Text('Normal'),
              ),
              DropdownMenuItem(
                value: 'Low',
                child: Text('Low'),
              ),
            ],
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _priority = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return _SectionCard(
      title: 'Send Options',
      icon: Icons.schedule_outlined,
      child: Column(
        children: [
          RadioGroup<String>(
            groupValue: _sendMode,
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _sendMode = value;

                if (_sendMode != 'Schedule') {
                  _scheduledAt = null;
                }
              });
            },
            child: const Column(
              children: [
                RadioListTile<String>(
                  value: 'Now',
                  title: Text('Send now'),
                  subtitle: Text(
                    'Send the notification immediately.',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  value: 'Schedule',
                  title: Text('Schedule'),
                  subtitle: Text(
                    'Choose a future date and time.',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                RadioListTile<String>(
                  value: 'Draft',
                  title: Text('Save as draft'),
                  subtitle: Text(
                    'Save the notification without sending it.',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          if (_sendMode == 'Schedule') ...[
            const SizedBox(height: 8),
            InkWell(
              onTap: _selectDateTime,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.30),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.event_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _scheduledAt == null
                            ? 'Select date & time'
                            : _formatDateTime(_scheduledAt!),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _scheduledAt == null
                              ? Colors.grey.shade600
                              : null,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: _isSubmitting ? null : _submit,
        icon: _isSubmitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Icon(
                switch (_sendMode) {
                  'Now' => Icons.send_outlined,
                  'Schedule' => Icons.schedule_send_outlined,
                  _ => Icons.save_outlined,
                },
              ),
        label: Text(
          _isSubmitting
              ? 'Processing...'
              : switch (_sendMode) {
                  'Now' => 'Send Notification',
                  'Schedule' => 'Schedule Notification',
                  _ => 'Save Draft',
                },
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '${date.day}/${date.month}/${date.year} '
        '$hour:$minute $period';
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 21,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
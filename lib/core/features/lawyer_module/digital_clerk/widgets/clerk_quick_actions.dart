import 'package:flutter/material.dart';

import '../screens/add_case_screen.dart';
import '../screens/add_client_screen.dart';
import '../screens/add_task_screen.dart';
import '../screens/add_reminder_screen.dart';

class ClerkQuickActions extends StatelessWidget {
  const ClerkQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickActionData(
        title: 'Add Task',
        icon: Icons.add_task_rounded,
        color: const Color(0xFF13294B),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskScreen()),
          );
        },
      ),

      _QuickActionData(
        title: 'Add Case',
        icon: Icons.gavel_outlined,
        color: const Color(0xFFD4AF37),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCaseScreen()),
          );
        },
      ),

      _QuickActionData(
        title: 'Add Client',
        icon: Icons.person_add_alt_1_outlined,
        color: const Color(0xFF2563EB),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddClientScreen()),
          );
        },
      ),

      _QuickActionData(
        title: 'Add Reminder',
        icon: Icons.notifications_active_outlined,
        color: const Color(0xFF7C3AED),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddReminderScreen()),
          );
        },
      ),
    ];

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
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF13294B),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Manage your daily work quickly',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];

              return _QuickActionButton(data: action);
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionData {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionData({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _QuickActionButton extends StatelessWidget {
  final _QuickActionData data;

  const _QuickActionButton({required this.data});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: data.color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data.icon, color: data.color, size: 20),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

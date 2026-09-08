import 'package:flutter/material.dart';
import 'package:lawlink360/core/features/client_module/scanner/screens/scanner_converter_home_screen.dart';
import 'package:lawlink360/core/features/client_module/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/appointments/screens/lawyer_appointment_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_messages/screens/lawyer_messages_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_settings/screens/lawyer_settings_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_help_support/screens/lawyer_help_support_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_drawer_dashboard/screens/lawyer_dashboard_screen.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_profile/screens/lawyer_profile_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/client_queries/screens/client_queries_screen.dart';
import 'package:lawlink360/core/features/lawyer_module/lawyer_documents/screens/lawyer_documents_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawlink360/auth/providers/auth_state_provider.dart';
import 'package:lawlink360/auth/screens/login_screen.dart';

class LawyerAppDrawer extends ConsumerWidget {
  const LawyerAppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: const Color(0xFFF5F7FB),
      child: SafeArea(
        child: Column(
          children: [
            // ==============================
            // DRAWER HEADER
            // ==============================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: const BoxDecoration(color: Color(0xFF13294B)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Avatar
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFD4AF37), width: 3),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 42,
                      color: Color(0xFF13294B),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Adv. Lawyer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Professional Lawyer',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),

                  const SizedBox(height: 12),

                  // Verification Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, size: 15, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Verified Lawyer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ==============================
            // MENU
            // ==============================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  _DrawerItem(
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LawyerDashboardScreen(),
                        ),
                      );
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.question_answer_outlined,
                    title: 'Client Queries',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ClientQueriesScreen(),
                        ),
                      );
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.people_outline,
                    title: 'My Clients',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'My Clients');
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.calendar_month_outlined,
                    title: 'Appointments',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LawyerAppointmentsScreen(),
                        ),
                      );
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.message_outlined,
                    title: 'Messages',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LawyerMessagesScreen(),
                        ),
                      );
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.folder_copy_outlined,
                    title: 'My Documents',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyDocumentsScreen(),
                        ),
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Divider(),
                  ),

                  _DrawerItem(
                    icon: Icons.edit_document,
                    title: 'Drafting',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Drafting');
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.menu_book_outlined,
                    title: 'Laws',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Laws ');
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.menu_book_outlined,
                    title: 'Judgments',
                    onTap: () {
                      Navigator.pop(context);
                      _showComingSoon(context, 'Judgments');
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Divider(),
                  ),

                  ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: const Text("Application"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApplicationHomeScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.gavel_outlined),
                    title: const Text("Procedure Guide"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GuiderHomeScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.verified_user_rounded,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Verification Hub'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VerificationScreen(),
                        ),
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Divider(),
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.document_scanner_outlined,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Scanner'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ScannerConverterHomeScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.translate_rounded,
                      color: Color(0xFFD4AF37),
                    ),
                    title: const Text('Translation'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TranslationScreen(),
                        ),
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Divider(),
                  ),

                  _DrawerItem(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LawyerProfileScreen(),
                        ),
                      );
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LawyerSettingsScreen(),
                        ),
                      );
                    },
                  ),

                  _DrawerItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LawyerHelpSupportScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ==============================
            // LOGOUT
            // ==============================
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: _DrawerItem(
                icon: Icons.logout_rounded,
                title: 'Logout',
                iconColor: Colors.redAccent,
                textColor: Colors.redAccent,
                onTap: () async {
                  await ref.read(authStateProvider.notifier).logout();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                'LawLink360 • Version 1.0.0',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be available soon.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ======================================================
// REUSABLE DRAWER ITEM
// ======================================================

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Icon(
        icon,
        color: iconColor ?? const Color(0xFF13294B),
        size: 23,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? const Color(0xFF1F2937),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}

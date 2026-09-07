import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawlink360/auth/screens/login_screen.dart';
import 'package:lawlink360/core/features/client_module/screens/find_lawyer_screen.dart';
import 'package:lawlink360/core/features/client_module/procedure_guide/screens/guider_home_screen.dart';
import 'package:lawlink360/core/features/scanner/screens/smart_camera_screen.dart';
import 'package:lawlink360/core/features/scanner/models/scanner_mode.dart';
import 'package:lawlink360/core/features/translation/screens/translation_screen.dart';
import 'package:lawlink360/core/features/client_module/verification/screens/verification_screen.dart';
import 'package:lawlink360/core/features/client_module/application/screens/application_home_screen.dart';
import 'package:lawlink360/core/features/profile/screens/profile_screen.dart';
import 'package:lawlink360/core/features/client_module/client_settings/screens/settings_screen.dart';
import 'package:lawlink360/core/features/help_support/screens/help_support_screen.dart';
import 'package:lawlink360/core/features/my_cases/screens/my_cases_screen.dart';
import 'package:lawlink360/core/features/client_module/appointments/screens/appointments_screen.dart';
import 'package:lawlink360/core/features/client_module/client_messages/screens/messages_screen.dart';
import 'package:lawlink360/core/features/client_module/documents/screens/documents_screen.dart';
import 'package:lawlink360/core/features/client_module/client_dashboard/screens/dashboard_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final userName = user?.displayName ?? "LawLink User";
    final userEmail = user?.email ?? "";
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(color: Color(0xFF0F172A)),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD4AF37),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      "assets/logos/lawlink360_transparent_logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    userEmail,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Client",
                    style: TextStyle(color: Color(0xFFD4AF37), fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.dashboard_rounded),
                    title: const Text("Dashboard"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DashboardScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.search_rounded),
                    title: const Text("Find Lawyer"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FindLawyerScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.work_outline_rounded),
                    title: const Text("My Cases"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyCasesScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.calendar_month_rounded),
                    title: const Text("Appointments"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AppointmentsScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.chat_bubble_outline_rounded),
                    title: const Text("Messages"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MessagesScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: const Text("Documents"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DocumentsScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(),

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
                    leading: const Icon(Icons.image),
                    title: const Text("Translation"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TranslationScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.verified_user_outlined),
                    title: const Text("Verification Hub"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerificationScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.document_scanner_outlined),
                    title: const Text("Scanner"),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SmartCameraScreen(
                            initialMode: ScannerMode.document,
                          ),
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

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text("My Profile"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("Settings"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.help_outline_rounded),
                    title: const Text("Help & Support"),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      const secureStorage = FlutterSecureStorage();

                      // Sign out from Firebase
                      await FirebaseAuth.instance.signOut();

                      // Disable biometric login for this signed-out session
                      await secureStorage.delete(key: 'biometric_enabled');

                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

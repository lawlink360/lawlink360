import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lawlink360/auth/screens/login_screen.dart';
import 'package:lawlink360/core/features/client/screens/find_lawyer_screen.dart';

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
                    onTap: () {},
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
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.calendar_month_rounded),
                    title: const Text("Appointments"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.chat_bubble_outline_rounded),
                    title: const Text("Messages"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: const Text("Documents"),
                    onTap: () {},
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text("My Profile"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.verified_user_outlined),
                    title: const Text("Verification Hub"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.gavel_outlined),
                    title: const Text("Pakistani Laws"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.smart_toy_outlined),
                    title: const Text("AI Legal Assistant"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.document_scanner_outlined),
                    title: const Text("Document Scanner"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.translate_outlined),
                    title: const Text("Translation"),
                    onTap: () {},
                  ),
                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.help_outline_rounded),
                    title: const Text("Help & Support"),
                    onTap: () {},
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
                      await FirebaseAuth.instance.signOut();

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

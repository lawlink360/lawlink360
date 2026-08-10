import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawlink360/auth/providers/auth_state_provider.dart';
import 'package:lawlink360/auth/screens/login_screen.dart';
import 'package:lawlink360/core/features/client_module/navigation/client_navigation_controller.dart';
import 'package:lawlink360/widgets/buttons/theme_toggle_button.dart';
import 'package:lawlink360/auth/widgets/role_card.dart';
import 'package:lawlink360/widgets/buttons/primary_button.dart';
import 'package:lawlink360/profile/providers/user_profile_provider.dart';

import 'package:lawlink360/core/features/lawyer_module/home/screens/lawyer_home_screen.dart';

class RoleSelectionScreen extends ConsumerStatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  ConsumerState<RoleSelectionScreen> createState() =>
      _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends ConsumerState<RoleSelectionScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              isDark
                  ? "assets/backgrounds/legal_background_blur.png"
                  : "assets/backgrounds/legal_background_light.png",
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withOpacity(0.45)
                  : Colors.white.withOpacity(0.3),
            ),
          ),
          // Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  // Empty space for floating buttons
                  const SizedBox(height: 50),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4AF37).withOpacity(0.35),
                              blurRadius: 40,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/logos/lawlink360_transparent_logo.png",
                        height: 85,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Welcome to LawLink360",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Choose how you'd like to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),
                  RoleCard(
                    title: "Client",
                    description:
                        "✓ Find Verified Lawyers\n✓ Book Consultations\n✓ Manage Legal Matters",
                    imagePath: "assets/illustrations/client.png",
                    selected: selectedRole == "client",
                    highlightColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        selectedRole = "client";
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  RoleCard(
                    title: "Lawyer",
                    description:
                        "Offer legal services?\n✓ Manage Clients\n✓ Receive Appointments\n✓ Grow Your Practice",
                    imagePath: "assets/illustrations/lawyer.png",
                    selected: selectedRole == "lawyer",
                    highlightColor: const Color(0xFFD4AF37),
                    onTap: () {
                      setState(() {
                        selectedRole = "lawyer";
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    text: "",
                    onPressed: selectedRole == null
                        ? null
                        : () async {
                            try {
                              await ref
                                  .read(userProfileProvider.notifier)
                                  .updateRole(selectedRole!);

                              if (!mounted) return;

                              if (selectedRole == "client") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ClientNavigationController(),
                                  ),
                                );
                              } else if (selectedRole == "lawyer") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LawyerHomeScreen(),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Unable to save your role: $e"),
                                ),
                              );
                            }
                          },
                  ),
                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock,
                        color: isDark ? Colors.white60 : Colors.black54,
                        size: 15,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Your information is 100% secure and encrypted",
                        style: TextStyle(
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // FLOATING HEADER - Sticky at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ThemeToggleButton(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        await ref.read(authStateProvider.notifier).logout();

                        if (!mounted) return;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: isDark ? Colors.white : Colors.black,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

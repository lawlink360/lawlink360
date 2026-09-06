import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawlink360/auth/providers/auth_state_provider.dart';
import 'package:lawlink360/auth/models/auth_state.dart';
import 'package:lawlink360/widgets/buttons/theme_toggle_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);
    final isDark = theme.brightness == Brightness.dark;

    // Set colors based on theme
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;
    final cardBgColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.7);
    final cardBorderColor = isDark ? Colors.white24 : Colors.black12;
    final inputFillColor = isDark
        ? Colors.white.withValues(alpha: 0.05)
        : Colors.black.withValues(alpha: 0.03);
    final inputBorderColor = isDark ? Colors.white24 : Colors.black12;
    final backButtonColor = isDark ? Colors.white : Colors.black;

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
                  ? Colors.black.withValues(alpha: 0.45)
                  : Colors.white.withValues(alpha: 0.3),
            ),
          ),
          // Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back button
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: backButtonColor,
                              ),
                            ),
                            // Theme button
                            const ThemeToggleButton(),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                                    color: const Color(
                                      0xFFD4AF37,
                                    ).withValues(alpha: 0.35),
                                    blurRadius: 40,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/logos/lawlink360_transparent_logo.png",
                              height: 90,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Enter your registered email address.\nWe'll send you a password reset link.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: subtitleColor,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: cardBgColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: cardBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: textColor),
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black54,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Color(0xFFD4AF37),
                                  ),
                                  filled: true,
                                  fillColor: inputFillColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: inputBorderColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFD4AF37),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                height: 58,
                                child: ElevatedButton(
                                  onPressed:
                                      authState.status == AuthStatus.loading
                                      ? null
                                      : () async {
                                          if (emailController.text
                                              .trim()
                                              .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Please enter your email.",
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          try {
                                            await ref
                                                .read(
                                                  authStateProvider.notifier,
                                                )
                                                .resetPassword(
                                                  emailController.text.trim(),
                                                );

                                            if (!context.mounted) return;

                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                title: const Text(
                                                  "✅ Reset Link Sent",
                                                ),
                                                content: const Text(
                                                  "We've sent a password reset link to your email.\n\n"
                                                  "Please check your inbox and spam folder.",
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: const Text(
                                                      "Continue",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } catch (e) {
                                            if (!context.mounted) return;

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(e.toString()),
                                              ),
                                            );
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD4AF37),
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: authState.status == AuthStatus.loading
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 22,
                                              height: 22,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              "Sending Reset Link...",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const Text(
                                          "SEND RESET LINK",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Remember your password? Back to Login",
                            style: TextStyle(
                              color: const Color(0xFFD4AF37),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

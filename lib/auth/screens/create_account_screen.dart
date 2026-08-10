import 'package:flutter/material.dart';
import 'package:lawlink360/widgets/buttons/theme_toggle_button.dart';
import 'package:lawlink360/auth/widgets/signup_header.dart';
import 'package:lawlink360/widgets/cards/glass_card.dart';
import 'package:lawlink360/auth/widgets/animated_text_field.dart';
import 'package:lawlink360/auth/widgets/social_login_button.dart';
import 'package:lawlink360/auth/widgets/create_account_button.dart';
import 'package:lawlink360/auth/widgets/terms_checkbox.dart';
import 'package:lawlink360/auth/screens/role_selection_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawlink360/auth/providers/auth_state_provider.dart';
import 'package:lawlink360/auth/models/auth_state.dart';

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool agreeTerms = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;
    final backButtonColor = isDark ? Colors.white : Colors.black;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;
    final overlayColor = isDark
        ? Colors.black.withOpacity(0.45)
        : Colors.white.withOpacity(0.3);

    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              isDark
                  ? 'assets/backgrounds/legal_background_blur.png'
                  : 'assets/backgrounds/legal_background_light.png',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay
          Positioned.fill(child: Container(color: overlayColor)),
          // Main Content - Scrollable
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
              child: Column(
                children: [
                  // Empty space for floating buttons (so content doesn't go under them)
                  const SizedBox(height: 40),
                  const SignupHeader(),
                  const SizedBox(height: 16),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            GlassCard(
                              child: Column(
                                children: [
                                  AnimatedTextField(
                                    controller: fullNameController,
                                    hintText: "Full Name",
                                    icon: Icons.person_outline,
                                  ),
                                  const SizedBox(height: 12),
                                  AnimatedTextField(
                                    controller: emailController,
                                    hintText: "Email Address",
                                    icon: Icons.email_outlined,
                                  ),
                                  const SizedBox(height: 12),
                                  AnimatedTextField(
                                    controller: phoneController,
                                    hintText: "Mobile Number",
                                    icon: Icons.phone_outlined,
                                  ),
                                  const SizedBox(height: 12),
                                  AnimatedTextField(
                                    controller: passwordController,
                                    hintText: "Password",
                                    icon: Icons.lock_outline,
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 12),
                                  AnimatedTextField(
                                    controller: confirmPasswordController,
                                    hintText: "Confirm Password",
                                    icon: Icons.lock_outline,
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 8),
                                  TermsCheckbox(
                                    value: agreeTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        agreeTerms = value ?? false;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  CreateAccountButton(
                                    onPressed: registerUser,
                                    isLoading:
                                        authState.status == AuthStatus.loading,
                                  ),
                                  const SizedBox(height: 18),
                                  // OR Divider
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 0.5,
                                          color: dividerColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          "OR",
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white54
                                                : Colors.black54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 0.5,
                                          color: dividerColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  SocialLoginButton(
                                    isLoading: false,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    color: subtitleColor,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: const Color(0xFFD4AF37),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // FLOATING HEADER - Overlay on top (not taking space)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: backButtonColor,
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    const ThemeToggleButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> registerUser() async {
    if (!agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept the Terms & Conditions.")),
      );
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match.")));
      return;
    }

    try {
      await ref
          .read(authStateProvider.notifier)
          .register(
            fullName: fullNameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            password: passwordController.text.trim(),
          );

      final authState = ref.read(authStateProvider);

      if (authState.status == AuthStatus.error) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authState.errorMessage ?? "Registration failed"),
          ),
        );
        return;
      }
      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 32),
                SizedBox(width: 10),
                Text("Success"),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "✓ Account Created Successfully!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text("Welcome to LawLink360", textAlign: TextAlign.center),
                SizedBox(height: 8),
                Text(
                  "Let's personalize your experience.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RoleSelectionScreen(),
                      ),
                    );
                  },
                  child: const Text("Continue"),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {}
  }
}

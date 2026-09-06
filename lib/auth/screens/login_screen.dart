import 'package:flutter/material.dart';

import 'package:lawlink360/widgets/buttons/theme_toggle_button.dart';
import 'package:lawlink360/widgets/cards/glass_card.dart';
import 'package:lawlink360/widgets/buttons/biometric_button.dart';

import 'package:lawlink360/auth/widgets/login_header.dart';
import 'package:lawlink360/auth/widgets/animated_text_field.dart';
import 'package:lawlink360/auth/widgets/login_button.dart';
import 'package:lawlink360/auth/widgets/social_login_button.dart';

import 'package:lawlink360/core/services/dialog_service.dart';
import 'package:lawlink360/core/services/biometric_service.dart';

import 'package:lawlink360/auth/screens/create_account_screen.dart';
import 'package:lawlink360/auth/screens/forgot_password_screen.dart';
import 'package:lawlink360/auth/screens/role_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lawlink360/auth/providers/auth_state_provider.dart';
import 'package:lawlink360/auth/models/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final BiometricService _biometricService = BiometricService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _isGoogleLoading = false;
  bool _rememberMe = false;
  bool _showBiometricButton = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
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
    _loadRememberMe();
    _loadBiometricStatus();
    _checkAutoBiometric();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();

    final remember = prefs.getBool('remember_me') ?? false;

    setState(() {
      _rememberMe = remember;
    });

    if (remember) {
      emailController.text = prefs.getString('saved_email') ?? '';
    }
  }

  Future<void> _loadBiometricStatus() async {
    final enabled = await _secureStorage.read(key: "biometric_enabled");

    if (!mounted) return;

    setState(() {
      _showBiometricButton = enabled == "true";
    });
  }

  Future<void> _checkAutoBiometric() async {
    final enabled = await _secureStorage.read(key: "biometric_enabled");

    if (enabled != "true") return;

    // Firebase session must exist before biometric login
    // can be used as a local authentication step.
    final firebaseUser = FirebaseAuth.instance.currentUser;

    debugPrint("AUTO BIOMETRIC: Firebase user = ${firebaseUser?.uid}");

    if (firebaseUser == null) {
      return;
    }

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    await biometricLogin();
  }

  Future<void> login() async {
    try {
      await ref
          .read(authStateProvider.notifier)
          .login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      if (!mounted) return;

      // IMPORTANT:
      // AuthNotifier catches Firebase errors internally.
      // Therefore we must check the authentication state here.
      final authState = ref.read(authStateProvider);

      if (authState.status != AuthStatus.authenticated) {
        await DialogService.showError(
          context: context,
          title: "Login Failed",
          message: _getFriendlyErrorMessage(
            authState.errorMessage ?? "Login failed",
          ),
        );
        return;
      }

      // Firebase login was successful.
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('remember_me', _rememberMe);

      if (_rememberMe) {
        await prefs.setString('saved_email', emailController.text.trim());
      } else {
        await prefs.remove('saved_email');
      }

      // Ask for biometric ONLY after successful Firebase login.
      final biometricEnabled = await _secureStorage.read(
        key: "biometric_enabled",
      );

      if (_rememberMe && biometricEnabled != "true") {
        await _askEnableBiometric();
      }

      if (!mounted) return;

      // Go to Role Selection ONLY after successful authentication.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      );
    } catch (e) {
      if (!mounted) return;

      await DialogService.showError(
        context: context,
        title: "Login Failed",
        message: _getFriendlyErrorMessage(e.toString()),
      );
    }
  }

  Future<void> googleLogin() async {
    try {
      setState(() => _isGoogleLoading = true);

      await ref.read(authStateProvider.notifier).signInWithGoogle();

      if (!mounted) return;

      setState(() => _isGoogleLoading = false);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _isGoogleLoading = false);

      await DialogService.showError(
        context: context,
        title: "Google Sign-In Failed",
        message: _getFriendlyErrorMessage(e.toString()),
      );
    }
  }

  Future<void> biometricLogin() async {
    final available = await _biometricService.isBiometricAvailable();

    if (!mounted) return;

    if (!available) {
      await DialogService.showError(
        context: context,
        title: "Biometric Authentication",
        message:
            "Your device does not support fingerprint or face authentication.",
      );
      return;
    }

    final authenticated = await _biometricService.authenticate();

    if (!mounted) return;

    if (!authenticated) {
      await DialogService.showError(
        context: context,
        title: "Authentication Failed",
        message: "Fingerprint authentication was cancelled or failed.",
      );
      return;
    }

    // -----------------------------------------
    // BIOMETRIC SUCCESSFUL
    // -----------------------------------------

    final firebaseUser = FirebaseAuth.instance.currentUser;

    debugPrint("BIOMETRIC: Firebase user = ${firebaseUser?.uid}");

    // Firebase session still exists
    if (firebaseUser != null) {
      await DialogService.showSuccess(
        context: context,
        title: "Authentication Successful",
        message: "Welcome back!",
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
      );

      return;
    }

    // -----------------------------------------
    // BIOMETRIC SUCCESSFUL BUT FIREBASE NULL
    // -----------------------------------------

    await DialogService.showError(
      context: context,
      title: "Session Expired",
      message:
          "Your fingerprint was verified, but your Firebase login session has expired. Please log in with your email and password again.",
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Future<void> _askEnableBiometric() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enable Fingerprint Login?"),
        content: const Text(
          "Would you like to use fingerprint authentication for faster and secure login on this device?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Not Now"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Enable"),
          ),
        ],
      ),
    );

    if (result == true) {
      await _secureStorage.write(key: "biometric_enabled", value: "true");

      await _secureStorage.write(key: "remember_me", value: "true");
    }
  }

  String _getFriendlyErrorMessage(String error) {
    if (error.contains("user-not-found")) {
      return "No account was found with this email address.";
    }

    if (error.contains("wrong-password")) {
      return "The password you entered is incorrect.";
    }

    if (error.contains("invalid-email")) {
      return "Please enter a valid email address.";
    }

    if (error.contains("email-already-in-use")) {
      return "An account with this email already exists.";
    }

    if (error.contains("weak-password")) {
      return "Your password is too weak.";
    }

    if (error.contains("network-request-failed")) {
      return "Please check your internet connection.";
    }

    return "Something went wrong. Please try again.";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final authState = ref.watch(authStateProvider);

    ref.listen(authStateProvider, (previous, next) {
      if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Login failed')),
        );
      }
    });

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      body: Stack(
        children: [
          // Background with overlay
          Positioned.fill(
            child: Image.asset(
              isDark
                  ? "assets/backgrounds/legal_background_blur.png"
                  : "assets/backgrounds/legal_background_light.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withValues(alpha:0.45)
                  : Colors.white.withValues(alpha:0.3),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
                child: Column(
                  children: [
                    const LoginHeader(),
                    const SizedBox(height: 28),

                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 90),
                              child: GlassCard(
                                child: Column(
                                  children: [
                                    AnimatedTextField(
                                      controller: emailController,
                                      hintText: "Email Address",
                                      icon: Icons.email_outlined,
                                    ),
                                    const SizedBox(height: 16),

                                    AnimatedTextField(
                                      controller: passwordController,
                                      hintText: "Password",
                                      icon: Icons.lock_outline,
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 22),

                                    Row(
                                      children: [
                                        Checkbox(
                                          value: _rememberMe,
                                          activeColor: const Color(0xFFD4AF37),
                                          onChanged: (value) {
                                            setState(() {
                                              _rememberMe = value ?? false;
                                            });
                                          },
                                        ),
                                        Text(
                                          "Remember Me",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    LoginButton(
                                      isLoading:
                                          authState.status ==
                                          AuthStatus.loading,
                                      onPressed: login,
                                    ),

                                    const SizedBox(height: 16),

                                    SocialLoginButton(
                                      onPressed: googleLogin,
                                      isLoading: _isGoogleLoading,
                                    ),

                                    const SizedBox(height: 24),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(color: colors.outline),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Text(
                                            "OR",
                                            style: TextStyle(
                                              color: isDark
                                                  ? colors.primary
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(color: colors.outline),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ),

                            if (_showBiometricButton)
                              Positioned(
                                bottom: -30,
                                child: BiometricButton(
                                  onPressed: biometricLogin,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: isDark
                                  ? colors.onSurface.withValues(alpha:0.70)
                                  : Colors.black87,
                            ),
                          ),
                        ),

                        Text("|", style: TextStyle(color: colors.outline)),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CreateAccountScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              color: isDark ? colors.primary : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Theme button - on top
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThemeToggleButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import '../../../auth/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
  begin: const Offset(0, 0.08),
  end: Offset.zero,
).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  ),
);

    _controller.forward();

    Timer(const Duration(milliseconds: 1600), () {
  if (!mounted) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => LoginScreen(),
    ),
  );
});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1F3A),
      body: FadeTransition(
  opacity: _fadeAnimation,
  child: SlideTransition(
    position: _slideAnimation,
    child: ScaleTransition(
      scale: _scaleAnimation,
          child: Image.asset(
            'assets/splash/lawlink360_splash.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    );
  }
}

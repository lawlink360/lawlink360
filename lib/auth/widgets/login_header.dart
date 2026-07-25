import 'package:flutter/material.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({super.key});

  @override
  State<LoginHeader> createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _scale = Tween<double>(
      begin: 0.9,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    // Continuous floating animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(
          reverse: true,
          period: const Duration(seconds: 3),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Set colors based on theme
    final titleColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white70 : Colors.black54;

    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _offset,
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      (_controller.value - 0.5) * 8,
                    ),
                    child: child,
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
                            blurRadius: 50,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/logos/lawlink360_transparent_logo.png',
                      height: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'LawLink360',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Pakistan's Smart Legal Platform",
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
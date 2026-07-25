import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lawlink360/core/providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return IconButton(
      onPressed: () {
  context.read<ThemeProvider>().toggleTheme();

  debugPrint(
    "Dark Mode: ${context.read<ThemeProvider>().isDarkMode}",
  );
},
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          themeProvider.isDarkMode
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          key: ValueKey(themeProvider.isDarkMode),
          color: const Color(0xFFD4AF37),
          size: 28,
        ),
      ),
    );
  }
}
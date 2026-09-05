import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/features/splash/splash_screen.dart';
import 'core/providers/theme_provider.dart';
import 'core/features/lawyer_module/lawyer_drafting/navigation/drafting_navigation.dart';

class LawLinkApp extends ConsumerWidget {
  const LawLinkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LawLink360',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      home: const SplashScreen(),

      onGenerateRoute: DraftingNavigation.onGenerateRoute,
    );
  }
}

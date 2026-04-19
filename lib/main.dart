import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: DeskReliefApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class DeskReliefApp extends StatelessWidget {
  final bool hasSeenOnboarding;

  const DeskReliefApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider dinlenerek aktif app palette ve themeMode alınıyor
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'DeskRelief',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.buildTheme(themeProvider.palette, isDark: false),
          darkTheme: AppTheme.buildTheme(themeProvider.palette, isDark: true),
          routerConfig: AppRouter.createRouter(hasSeenOnboarding: hasSeenOnboarding),
        );
      },
    );
  }
}

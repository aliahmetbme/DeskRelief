import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'features/auth/presentation/viewmodels/auth_view_model.dart';
import 'features/assessment/presentation/viewmodels/red_flags_view_model.dart';
import 'features/assessment/presentation/viewmodels/body_map_view_model.dart';
import 'features/scheduling/presentation/viewmodels/scheduling_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RedFlagsViewModel()),
        ChangeNotifierProvider(create: (_) => BodyMapViewModel()),
        ChangeNotifierProvider(create: (_) => SchedulingViewModel()),
      ],
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
          theme: AppTheme.buildTheme(context, themeProvider.palette, isDark: false),
          darkTheme: AppTheme.buildTheme(context, themeProvider.palette, isDark: true),
          routerConfig: AppRouter.createRouter(hasSeenOnboarding: hasSeenOnboarding),
        );
      },
    );
  }
}

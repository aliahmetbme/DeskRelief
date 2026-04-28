import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:deskrelief/l10n/app_localizations.dart';

import 'core/providers/locale_provider.dart';
import 'core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'features/auth/presentation/viewmodels/auth_view_model.dart';
import 'features/assessment/presentation/viewmodels/red_flags_view_model.dart';
import 'features/assessment/presentation/viewmodels/body_map_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Turkish date formatting
  await initializeDateFormatting('tr_TR', null);

  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => RedFlagsViewModel()),
        ChangeNotifierProvider(create: (_) => BodyMapViewModel()),
      ],
      child: DeskReliefApp(hasSeenOnboarding: hasSeenOnboarding),
    ),
  );
}

class DeskReliefApp extends StatefulWidget {
  final bool hasSeenOnboarding;

  const DeskReliefApp({super.key, required this.hasSeenOnboarding});

  @override
  State<DeskReliefApp> createState() => _DeskReliefAppState();
}

class _DeskReliefAppState extends State<DeskReliefApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(
      hasSeenOnboarding: widget.hasSeenOnboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ThemeProvider dinlenerek aktif app palette ve themeMode alınıyor
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final localeProvider = Provider.of<LocaleProvider>(context);
        return MaterialApp.router(
          title: 'DeskRelief',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: AppTheme.buildTheme(
            context,
            themeProvider.palette,
            isDark: false,
          ),
          darkTheme: AppTheme.buildTheme(
            context,
            themeProvider.palette,
            isDark: true,
          ),
          locale: localeProvider.locale ?? const Locale('tr'),
          supportedLocales: const [Locale('tr'), Locale('en')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: _router,
        );
      },
    );
  }
}

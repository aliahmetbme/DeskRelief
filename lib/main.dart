import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'core/providers/locale_provider.dart';
import 'core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'features/auth/presentation/viewmodels/auth_view_model.dart';
import 'features/assessment/presentation/viewmodels/red_flags_view_model.dart';
import 'features/assessment/presentation/viewmodels/body_map_view_model.dart';
import 'features/main/presentation/viewmodels/dashboard_view_model.dart';
import 'features/scheduling/data/services/notification_service.dart';
import 'features/exercise/data/services/video_cache_service.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ekran yönünü dikey (portrait) olarak kitle
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Notifications
  final notificationService = NotificationService();
  await notificationService.initialize();

  // Initialize dynamic date formatting based on system locale
  final String systemLocale = ui.PlatformDispatcher.instance.locale.toString();
  await initializeDateFormatting(systemLocale, null);

  // Initialize Video Caching
  await VideoCacheService().init();

  // İlk kurulum kontrolü
  await checkFirstRun();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProxyProvider<AuthViewModel, RedFlagsViewModel>(
          create: (context) => RedFlagsViewModel(
            authViewModel: Provider.of<AuthViewModel>(context, listen: false),
          ),
          update: (context, auth, previous) =>
              previous ?? RedFlagsViewModel(authViewModel: auth),
        ),
        ChangeNotifierProvider(create: (_) => BodyMapViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: const DeskReliefApp(),
    ),
  );
}

Future<void> checkFirstRun() async {
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstRun = prefs.getBool('is_first_run') ?? true;

  if (isFirstRun) {
    await FirebaseAuth.instance.signOut();
    await prefs.setBool('is_first_run', false);
  }
}

class DeskReliefApp extends StatefulWidget {
  const DeskReliefApp({super.key});

  @override
  State<DeskReliefApp> createState() => _DeskReliefAppState();
}

class _DeskReliefAppState extends State<DeskReliefApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.createRouter(
      authViewModel: context.read<AuthViewModel>(),
    );

    // İlk yüklemede bildirim izinlerini iste
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().requestPermissions();
    });
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

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'features/assessment/presentation/viewmodels/pain_intensity_view_model.dart';
import 'features/exercise/presentation/viewmodels/daily_routine_view_model.dart';
import 'features/scheduling/presentation/viewmodels/scheduling_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/services/content_service.dart';

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

  // Initialize Content Service
  await ContentService().init();

  // İlk kurulum kontrolü
  await checkFirstRun();

  // Load Theme Preference before runApp to prevent flicker
  final prefs = await SharedPreferences.getInstance();
  final String? modeStr = prefs.getString('themeModeV2');
  AppThemeMode initialThemeMode = AppThemeMode.system;

  if (modeStr != null) {
    initialThemeMode = AppThemeMode.values.firstWhere(
      (e) => e.name == modeStr,
      orElse: () => AppThemeMode.system,
    );
  } else {
    // Legacy fallback
    final String? oldMode = prefs.getString('themeMode');
    if (oldMode == 'dark') {
      initialThemeMode = AppThemeMode.medical;
    } else if (oldMode == 'light') {
      initialThemeMode = AppThemeMode.light;
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(initialMode: initialThemeMode)),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        Provider(create: (_) => ContentService()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProxyProvider<AuthViewModel, RedFlagsViewModel>(
          create: (context) => RedFlagsViewModel(
            authViewModel: Provider.of<AuthViewModel>(context, listen: false),
          ),
          update: (context, auth, previous) =>
              previous ?? RedFlagsViewModel(authViewModel: auth),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, BodyMapViewModel>(
          create: (_) => BodyMapViewModel(),
          update: (_, auth, previous) => (previous ?? BodyMapViewModel())
            ..updateUser(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, PainIntensityViewModel>(
          create: (_) => PainIntensityViewModel(),
          update: (_, auth, previous) => (previous ?? PainIntensityViewModel())
            ..updateUser(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, DashboardViewModel>(
          create: (_) => DashboardViewModel(),
          update: (_, auth, previous) => (previous ?? DashboardViewModel())
            ..updateUser(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, DailyRoutineViewModel>(
          create: (_) => DailyRoutineViewModel(),
          update: (_, auth, previous) => (previous ?? DailyRoutineViewModel())
            ..updateUser(auth.currentUser),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, SchedulingViewModel>(
          create: (_) => SchedulingViewModel(),
          update: (_, auth, previous) => (previous ?? SchedulingViewModel())
            ..updateUser(auth.currentUser),
        ),
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
          theme: AppTheme.buildTheme(
            context,
            themeProvider.palette,
            isDark: themeProvider.themeMode == AppThemeMode.medical || 
                    (themeProvider.themeMode == AppThemeMode.system && 
                     MediaQuery.of(context).platformBrightness == Brightness.dark),
            isTrueDark: themeProvider.themeMode == AppThemeMode.dark,
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

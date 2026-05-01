import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/viewmodels/auth_view_model.dart';

import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/welcome_profile_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/assessment/presentation/pages/red_flags_page.dart';
import '../../features/assessment/presentation/pages/body_map_page.dart';
import '../../features/assessment/presentation/pages/pain_intensity_page.dart';
import '../../features/scheduling/presentation/pages/scheduling_page.dart';
import '../../features/scheduling/presentation/viewmodels/scheduling_view_model.dart';
import '../../features/main/presentation/pages/main_layout_page.dart';
import '../../features/main/presentation/pages/dashboard_page.dart';
import '../../features/main/presentation/pages/calendar_page.dart';
import '../../features/main/presentation/pages/profile_page.dart';
import '../../features/assessment/presentation/pages/exclusion_criteria_settings_page.dart';
import '../../features/exercise/presentation/pages/daily_routine_page.dart';
import '../../features/exercise/presentation/pages/exercise_detail_page.dart';
import '../../features/exercise/presentation/pages/exercise_video_page.dart';
import '../../features/exercise/presentation/viewmodels/daily_routine_view_model.dart';
import '../../features/exercise/domain/models/exercise_model.dart';

class AppRouter {
  static GoRouter createRouter({
    required AuthViewModel authViewModel,
  }) {
    return GoRouter(
      initialLocation: '/splash',
      refreshListenable: authViewModel,
      redirect: (context, state) {
        final location = state.matchedLocation;
        
        // DURUM 1: Başlatma Kontrolü (Splash State)
        // Firebase Auth ve Local SharedPreferences verileri gelene kadar Splash'te kal.
        if (!authViewModel.isInitialized) {
          return '/splash';
        }

        // DURUM 2: Kullanıcı Giriş Yapmamışsa
        final user = authViewModel.currentUser;
        if (user == null) {
          // Önce Intro (Onboarding) kontrolü
          if (!authViewModel.hasSeenOnboarding) {
            if (location == '/onboarding') return null;
            return '/onboarding';
          }
          
          // Intro görüldüyse giriş sayfasına yönlendir
          final bool isOnAuthPages = 
              location == '/signin' || 
              location == '/signup' || 
              location == '/onboarding';
              
          if (isOnAuthPages) return null;
          return '/signin';
        }

        // DURUM 3: Giriş Yapılmışsa (Progress Kontrolü)
        final target = authViewModel.checkUserProgress(user);
        
        // Eğer hedef ana sayfa ise ve kullanıcı hala kayıt/auth sayfalarındaysa /home'a çek
        if (target == '/home') {
          final bool isOnRestrictedPages = 
              location == '/signin' || 
              location == '/signup' || 
              location == '/onboarding' ||
              location == '/splash' ||
              location == '/welcome-profile' || 
              location == '/red-flags' || 
              location == '/body-map' || 
              location == '/assessment/pain-intensity' || 
              location == '/scheduling';
              
          if (isOnRestrictedPages) return '/home';
          return null;
        }

        // Kayıt akışı tamamlanmamışsa hedef sayfaya zorla gönder
        if (location != target) {
          return target;
        }

        return null;
      },
      routes: [
        // ── Splash Screen ──────────────────────────────────────────────────
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        // ── Auth & Assessment akışı (top-level rotalar) ─────────────────────
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => const SignInPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: '/welcome-profile',
          builder: (context, state) => const WelcomeProfilePage(),
        ),
        GoRoute(
          path: '/red-flags',
          builder: (context, state) => const RedFlagsPage(),
        ),
        GoRoute(
          path: '/body-map',
          builder: (context, state) => const BodyMapPage(),
        ),
        GoRoute(
          path: '/assessment/pain-intensity',
          builder: (context, state) {
            // Önce extra'dan bak, yoksa AuthViewModel'den çek
            List<String> regions = state.extra as List<String>? ?? [];
            if (regions.isEmpty) {
              final user = context.read<AuthViewModel>().currentUser;
              regions = user?.painRegions.map((e) => e.regionId).toList() ?? [];
            }
            return PainIntensityPage(selectedRegions: regions);
          },
        ),
        GoRoute(
          path: '/profile/exclusion-criteria',
          builder: (context, state) => const ExclusionCriteriaSettingsPage(),
        ),
        GoRoute(
          path: '/scheduling',
          builder: (context, state) {
            // Önce extra'dan bak, yoksa AuthViewModel'den çek
            List<String> regions = state.extra as List<String>? ?? [];
            if (regions.isEmpty) {
              final user = context.read<AuthViewModel>().currentUser;
              regions = user?.painRegions.map((e) => e.regionId).toList() ?? [];
            }
            return ChangeNotifierProvider(
              create: (_) => SchedulingViewModel(focusRegions: regions),
              child: const SchedulingPage(),
            );
          },
        ),

        GoRoute(
          path: '/exercise/daily-routine',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => DailyRoutineViewModel(),
            child: const DailyRoutinePage(),
          ),
        ),
        GoRoute(
          path: '/exercise/detail',
          builder: (context, state) {
            final exercise = state.extra as ExerciseItem;
            return ExerciseDetailPage(exercise: exercise);
          },
        ),
        GoRoute(
          path: '/exercise/video',
          builder: (context, state) {
            final videoUrl = state.extra as String;
            return ExerciseVideoPage(videoUrl: videoUrl);
          },
        ),

        // ── Ana İskelet — StatefulShellRoute.indexedStack ───────────────────
        // Her dal (branch) kendi Navigator stack'ini korur;
        // sekmeler arasında geçiş yapılırken state kaybolmaz.
        StatefulShellRoute(
          builder: (context, state, navigationShell) {
            return navigationShell;
          },
          navigatorContainerBuilder: (context, navigationShell, children) {
            return MainLayoutPage(
              navigationShell: navigationShell,
              children: children,
            );
          },
          branches: [
            // Şube 0: Ana Sayfa
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  builder: (context, state) => const DashboardPage(),
                ),
              ],
            ),

            // Şube 1: Takvim
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/calendar',
                  builder: (context, state) => const CalendarPage(),
                ),
              ],
            ),

            // Şube 2: Profil
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const ProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

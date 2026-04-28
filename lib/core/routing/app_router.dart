import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/welcome_profile_page.dart';
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

class AppRouter {
  static GoRouter createRouter({required bool hasSeenOnboarding}) {
    return GoRouter(
      initialLocation: hasSeenOnboarding ? '/home' : '/onboarding',
      routes: [
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
            final regions = state.extra as List<String>? ?? [];
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
            final regions = state.extra as List<String>? ?? [];
            return ChangeNotifierProvider(
              create: (_) => SchedulingViewModel(focusRegions: regions),
              child: const SchedulingPage(),
            );
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

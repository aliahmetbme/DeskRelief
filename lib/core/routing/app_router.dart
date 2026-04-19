import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/auth/presentation/pages/welcome_profile_page.dart';
import '../../features/assessment/presentation/pages/red_flags_page.dart';
import '../../features/assessment/presentation/pages/body_map_page.dart';

class AppRouter {
  static GoRouter createRouter({required bool hasSeenOnboarding}) {
    return GoRouter(
      initialLocation: hasSeenOnboarding ? '/body-map' : '/onboarding',
      routes: [
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
      ],
    );
  }
}

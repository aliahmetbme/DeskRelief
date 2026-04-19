import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';

class AppRouter {
  static GoRouter createRouter({required bool hasSeenOnboarding}) {
    return GoRouter(
      initialLocation: hasSeenOnboarding ? '/signup' : '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    );
  }
}

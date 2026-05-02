// This is a basic Flutter widget test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:deskrelief/main.dart';
import 'package:deskrelief/core/theme/theme_provider.dart';
import 'package:deskrelief/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:deskrelief/features/assessment/presentation/viewmodels/red_flags_view_model.dart';
import 'package:deskrelief/features/assessment/presentation/viewmodels/body_map_view_model.dart';

void main() {
  testWidgets('DeskReliefApp smoke test', (WidgetTester tester) async {
    // Tüm gerekli provider'lar ile uygulamamızı ayağa kaldırıp test ediyoruz
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider(initialMode: AppThemeMode.system)),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProxyProvider<AuthViewModel, RedFlagsViewModel>(
            create: (context) => RedFlagsViewModel(
              authViewModel: context.read<AuthViewModel>(),
            ),
            update: (context, auth, previous) =>
                previous ?? RedFlagsViewModel(authViewModel: auth),
          ),
          ChangeNotifierProvider(create: (_) => BodyMapViewModel()),
        ],
        child: const DeskReliefApp(),
      ),
    );

    // Uygulamanın sorunsuz bir şekilde yüklendiğini teyit edelim
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

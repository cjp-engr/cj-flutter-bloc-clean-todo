import 'package:flutter/material.dart';

import 'package:frontend/2_application/core/services/theme_service.dart';
import 'package:frontend/injection.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di;
import 'package:frontend/3_core/utils/init_firebase.dart' as init_fb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await init_fb.initializeFirebase();
  runApp(
    MyApp(router: sl()),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode:
                themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}

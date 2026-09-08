import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_provider/app_provider.dart';
import 'localization/app_localizations.dart';
import 'modules/splashScreen/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AppProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff1E1E1E),
      ),

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: const SplashScreen(),
    );
  }
}

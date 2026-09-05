import 'package:flutter/material.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding2_screen.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding3_screen.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding4_screen.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding5_screen.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding6_screen.dart';
import 'package:provider/provider.dart';
import 'core/app_provider/app_provider.dart';
import 'localization/app_localizations.dart';
import 'modules/onBoarding/screens/onboarding1_screen.dart';

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

      home: const onBoarding1(),
    );
  }
}

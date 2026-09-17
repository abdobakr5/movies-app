import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/app_provider/app_provider.dart';
import 'core/localization/app_localizations.dart';
import 'features/splash/presentation/views/splash_screen.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServicesLocator();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: const MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

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
      home:
          // BlocProvider(
          //   create: (context)=>getIt<ProfileCubit>(),

          //   child:
          const SplashScreen(),
      // ),
    );
  }
}

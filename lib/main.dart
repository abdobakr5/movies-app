import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/features/profile/domain/usecases/wishlist_usecase.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/app_provider/app_provider.dart';
import 'core/localization/app_localizations.dart';
import 'features/splash/presentation/views/splash_screen.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp();

   servicesLocator();

   //test the logic of profile screen

   try {
     final WishlistUsecase=getIt<GetWishlistUsecase>();
     final result =await WishlistUsecase.call();
     print(" success");
     print(result);
   } catch (e) {
     print("Error:$e");
   }
 

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
        scaffoldBackgroundColor: AppColors.surfaceColor,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashScreen(),
    );
  }
}

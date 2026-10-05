import 'package:flutter/material.dart';
import 'package:movies_app/features/profile/domain/usecases/wishlist_usecase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/cubit/app_cubit.dart';
import 'core/localization/app_localizations.dart';
import 'features/splash/presentation/views/splash_screen.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  servicesLocator();

  // test the logic of profile screen
  try {
    final wshlistUsecase = getIt<GetWishlistUsecase>();
    final result = await wshlistUsecase.call();
    debugPrint('Success');
    debugPrint(result.toString());
  } catch (e) {
    debugPrint('Error: $e');
  }

  runApp(
    BlocProvider(
      create: (_) => AppCubit(),
      child: const MoviesApp(),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          locale: state.locale,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xff1E1E1E),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SplashScreen(),
        );
      },
    );
  }
}

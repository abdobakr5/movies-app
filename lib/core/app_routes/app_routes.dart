import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/features/auth/ui/cubit/login_cubit.dart';
import 'package:movies_app/features/auth/ui/screens/forget_password_screen.dart';
import 'package:movies_app/features/auth/ui/screens/login_screen.dart';
import 'package:movies_app/features/auth/ui/screens/register_screen.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/home_tab/cubit/home_cubit.dart';
import 'package:movies_app/features/movies/ui/screens/home_screen.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/main_layout_screen.dart';
import 'package:movies_app/features/onboarding/ui/screens/onboarding1_screen.dart';
import 'package:movies_app/features/onboarding/ui/screens/onboarding2_screen.dart';
import 'package:movies_app/features/onboarding/ui/screens/onboarding3_screen.dart';
import 'package:movies_app/features/onboarding/ui/screens/onboarding4_screen.dart';
import 'package:movies_app/features/onboarding/ui/screens/onboarding5_screen.dart';
import 'package:movies_app/features/onboarding/ui/screens/onboarding6_screen.dart';
import 'package:movies_app/features/movies/ui/screens/update_profile/update_profile_screen.dart';
import 'package:movies_app/features/movie_details/ui/cubit/movie_details_cubit.dart';
import 'package:movies_app/features/movie_details/ui/screens/movie_details_screen.dart';

class AppRoutes {
  static Route onboarding1() =>
      MaterialPageRoute(builder: (_) => const Onboarding1Screen());

  static Route onboarding2() =>
      MaterialPageRoute(builder: (_) => const Onboarding2Screen());

  static Route onboarding3() =>
      MaterialPageRoute(builder: (_) => const Onboarding3Screen());

  static Route onboarding4() =>
      MaterialPageRoute(builder: (_) => const Onboarding4Screen());

  static Route onboarding5() =>
      MaterialPageRoute(builder: (_) => const Onboarding5Screen());

  static Route onboarding6() =>
      MaterialPageRoute(builder: (_) => const Onboarding6Screen());

  static Route login() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        ),
      );

  static Route register() =>
      MaterialPageRoute(builder: (_) => const RegisterScreen());

  static Route forgetPassword() =>
      MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

  static Route updateProfile() =>
      MaterialPageRoute(builder: (_) => const UpdateProfileScreen());

  static Route home() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<HomeCubit>(),
          child: const HomeScreen(),
        ),
      );

  static Route mainLayout() =>
      MaterialPageRoute(builder: (_) => const MainLayoutScreen());

  static Route movieDetails(int movieId) => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<MovieDetailsCubit>()..loadMovieDetails(movieId),
          child: MovieDetailsScreen(movieId: movieId),
        ),
      );
}

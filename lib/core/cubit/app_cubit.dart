import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  void changeTheme(ThemeMode theme) {
    emit(state.copyWith(themeMode: theme));
  }

  void changeLocale(Locale newLocale) {
    emit(state.copyWith(locale: newLocale));
  }
}

class AppState {
  final ThemeMode themeMode;
  final Locale locale;

  AppState({
    this.themeMode = ThemeMode.light,
    this.locale = const Locale('en'),
  });

  bool get isLight => themeMode == ThemeMode.light;

  bool get isDark => themeMode == ThemeMode.dark;

  bool get isEnglish => locale == const Locale('en');

  bool get isArabic => locale == const Locale('ar');

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
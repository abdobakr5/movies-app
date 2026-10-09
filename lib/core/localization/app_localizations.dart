import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;
import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  String get personalizeYourExperience;
  String get personalizeYourExperienceDescription;
  String get language;
  String get english;
  String get arabic;
  String get theme;
  String get letsStart;
  String get next;
  String get back;
  String get finish;
  String get findYourNextFavoriteMovieHere;
  String get findYourNextFavoriteMovieHereDescription;
  String get discoverMovies;
  String get discoverMoviesDescription;
  String get exploreAllGenres;
  String get exploreAllGenresDescription;
  String get createWatchlist;
  String get createWatchlistDescription;
  String get rateReviewAndLearn;
  String get rateReviewAndLearnDescription;
  String get startWatchingNow;
  String get exploreNow;
  String get email;
  String get password;
  String get confirmPassword;
  String get login;
  String get register;
  String get dontHaveAccount;
  String get alreadyHaveAccount;
  String get createOne;
  String get or;
  String get loginWithGoogle;
  String get name;
  String get phoneNumber;
  String get createAccount;
  String get accountCreatedSuccessfully;
  String get forgetPassword;
  String get verifyEmail;
  String get passwordResetEmailSent;
  String get pleaseEnterName;
  String get pleaseEnterEmail;
  String get pleaseEnterValidEmail;
  String get passwordMinLength;
  String get passwordsDoNotMatch;
  String get pleaseEnterPhone;
  String get invalidEmailAddress;
  String get userNotFound;
  String get networkError;
  String get tooManyRequests;
  String get somethingWentWrong;
  String get pickAvatar;
  String get avatar;
  String get resetPassword;
  String get deleteAccount;
  String get updateData;
  String get profileUpdatedSuccessfully;
  String get accountDeletedSuccessfully;
  String get getHistory;
  String get seeMore;
  String get searchScreen;
  String get exploreScreen;
  String get profileScreen;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale".'
  );
}

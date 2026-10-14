<p align="center">
  <img src="assets/logo/app_logo.png" alt="Movie Route logo" width="110" />
</p>

<h1 align="center">Movie Route</h1>

<p align="center">
  A Flutter movies app: browse films by genre, search, open full details, watch trailers, and keep a personal watchlist and history synced with Firebase.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart" alt="Dart" />
  <img src="https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-FFCA28?logo=firebase" alt="Firebase" />
  <img src="https://img.shields.io/badge/State-Bloc%20%2F%20Cubit-blue" alt="Bloc" />
</p>

---

## Features

**Authentication**
- Email and password sign up with name, phone and avatar
- Email login and Google Sign-In
- Forgot password (reset email)
- Session check on launch: logged-in users go straight to the app

**Home**
- Banner carousel of featured movies
- Horizontal lists by genre: Action, Romance, Drama, Horror

**Search**
- Live search with debounce

**Browse**
- Genre tabs built from the loaded movies, with a movie grid per genre

**Movie details**
- Poster, rating, runtime, likes, screenshots, summary, cast and genres
- Similar movies
- Bookmark to the watchlist
- Trailer playback inside the app (YouTube player)
- Every opened movie is saved to the user's history

**Profile**
- User avatar and name from Firestore
- Real Wish List and History counts for the logged-in user
- Watch List and History tabs listing the saved movies, newest first
- Edit profile (name, phone, avatar) and delete account
- Logout

**General**
- Onboarding flow (6 screens) and animated splash screen
- English and Arabic localization
- Dark theme with a yellow accent

---

## Tech stack

| Area | Package |
|---|---|
| State management | `flutter_bloc` (Cubit), `equatable` |
| Dependency injection | `get_it` |
| Networking | `http` |
| Backend | `firebase_core`, `firebase_auth`, `cloud_firestore` |
| Google login | `google_sign_in` |
| Trailers | `youtube_player_iframe` |
| Local storage | `shared_preferences` |
| UI | `flutter_svg`, `animate_do` |
| Localization | `flutter_localizations`, `intl` |

Movie data comes from a YTS-compatible API: `https://movies-api.accel.li/api/v2` (`list_movies`, `movie_details`, `movie_suggestions`).

---

## Architecture

The app follows **Clean Architecture** with a feature-first structure. Each feature is split into three layers:

| Layer | Contains | Rule |
|---|---|---|
| `ui` | Screens, widgets, cubits | Talks only to use cases |
| `domain` | Entities, abstract repositories, use cases | Pure Dart, no Firebase or HTTP |
| `data` | Models, data sources, repository implementations | The only layer that calls Firebase or the API |

All dependencies are registered in `lib/core/services/services_locator.dart` with `get_it`.

### Project structure

```
lib/
├── core/
│   ├── app_routes/          # AppRoutes: all navigation routes
│   ├── cubit/               # AppCubit (language and theme)
│   ├── localization/        # .arb files and generated localizations (en, ar)
│   ├── network/             # ApiManager, ApiConstants
│   ├── services/            # services_locator.dart (get_it)
│   ├── theme/               # AppColors
│   ├── utils/               # assets, styles, strings, validators
│   └── widgets/             # shared widgets (buttons, text fields, avatar selector)
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repository/
│   │   │       ├── data_source/auth_remote_data_source.dart
│   │   │       └── auth_repo_impl.dart
│   │   ├── domain/
│   │   │   ├── repository/auth_repo.dart
│   │   │   └── usecase/     # login, google login, register, reset password
│   │   └── ui/
│   │       ├── cubit/
│   │       └── screens/     # login, register, forget password
│   │
│   ├── movies/              # home, browse, search and profile
│   │   ├── data/
│   │   ├── domain/
│   │   └── ui/screens/
│   │       ├── main_tab/
│   │       │   ├── main_layout_screen.dart
│   │       │   ├── cubit/
│   │       │   ├── widgets/custom_bottom_nav_bar.dart
│   │       │   └── tabs/
│   │       │       ├── home_tab/
│   │       │       ├── search_tab/
│   │       │       ├── browse_tab/
│   │       │       └── profile_tab/
│   │       └── update_profile/
│   │
│   ├── movie_details/       # details, bookmarks, history, trailer
│   ├── onboarding/
│   └── splash/
│
├── firebase_options.dart
└── main.dart
```

---

## Firestore data

```
users/{uid}
  name, email, phone, avatarIndex, createdAt
  ├── watchlist/{movieId}   bookmarked movies (movieId, title, rating, covers, genres, createdAt …)
  └── history/{movieId}     opened movies (id, title, posterPath, rating, visitedAt)
```

`avatarIndex` is the index of the avatar in `AppAssets.allAvatars`.

---

## Getting started

### Requirements
- Flutter SDK 3.24 or newer
- Xcode and CocoaPods for iOS
- Android Studio / Android SDK for Android (min SDK 24)

### Run the app

```bash
git clone https://github.com/iMohamedMamdouh/movie-test.git
cd movie-test
flutter pub get

# iOS only
cd ios && pod install && cd ..

flutter run
```

### Firebase

The project is already connected to a Firebase project through
`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist` and `lib/firebase_options.dart`.

To use your own Firebase project:
1. Create a project in the [Firebase console](https://console.firebase.google.com/).
2. Enable **Email/Password** and **Google** sign-in under Authentication.
3. Create a **Cloud Firestore** database.
4. Run `flutterfire configure` to regenerate the three config files above.

### Tests and analysis

```bash
flutter analyze
flutter test
```

---

## App info

| | |
|---|---|
| App name | Movie Route |
| Android package | `com.example.movies_app` |
| Launcher icon | `assets/logo/app_logo.png` |

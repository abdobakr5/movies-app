import 'package:get_it/get_it.dart';
import 'package:movies_app/features/movies/data/repository/data_source/movie_remote_data_source.dart';
import 'package:movies_app/features/movies/data/repository/movie_repo_impl.dart';
import 'package:movies_app/features/movies/domain/repository/movie_repo.dart';
import 'package:movies_app/features/movies/domain/usecase/get_movies_usecase.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/home_tab/cubit/home_cubit.dart';
import 'package:movies_app/features/movies/data/repository/data_source/profile_remote_data_source.dart';
import 'package:movies_app/features/movies/data/repository/profile_repo_impl.dart';
import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';
import 'package:movies_app/features/movies/domain/usecase/delete_account_usecase.dart';
import 'package:movies_app/features/movies/domain/usecase/history_usecase.dart';
import 'package:movies_app/features/movies/domain/usecase/logout_usecase.dart';
import 'package:movies_app/features/movies/domain/usecase/update_profile_usecase.dart';
import 'package:movies_app/features/movies/domain/usecase/wishlist_usecase.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/profile_tab/cubit/profile_cubit.dart';

import 'package:movies_app/features/movies/domain/usecase/get_user_data_usecase.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/search_tab/cubit/search_cubit.dart';
import 'package:movies_app/core/network/api_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:movies_app/features/movies/data/repository/data_source/browse_remote_data_source.dart';
import 'package:movies_app/features/movies/data/repository/browse_repo_impl.dart';
import 'package:movies_app/features/movies/domain/repository/browse_repo.dart';
import 'package:movies_app/features/movies/ui/screens/main_tab/tabs/browse_tab/cubit/browse_cubit.dart';
import 'package:movies_app/features/movies/data/repository/data_source/browse_firebase_data_source.dart';

final getIt = GetIt.instance;

void servicesLocator() {



  getIt.registerLazySingleton<ApiManager>(() => ApiManager());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<GetMoviesUseCase>(
    () => GetMoviesUseCase(getIt()),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt()),
  );

  getIt.registerFactory<SearchCubit>(
        () => SearchCubit(getIt()),
  );

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      firestore:getIt(),auth:getIt()
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepoImplementation(getIt()),
  );

  getIt.registerLazySingleton<GetUserDataUsecase>(
        () => GetUserDataUsecase(getIt()),
  );

  getIt.registerLazySingleton(() => UpdateProfileUsecase(getIt()));

  getIt.registerLazySingleton(() => DeleteAccountUsecase(getIt()));

  getIt.registerLazySingleton(()=>LogoutUsecase(getIt()));

  getIt.registerLazySingleton(()=>GetWishlistUsecase(getIt()));

  getIt.registerLazySingleton(()=>GetHistoryUsecase(getIt()));




  getIt.registerFactory(
    () => ProfileCubit(
      updateProfileUsecase: getIt(),
      deleteAccountUseCase: getIt(),
      getUserDataUsecase: getIt(),
      logoutUsecase:getIt(),
      getWishlistUsecase:getIt(),
      getHistoryUseCase:getIt(),
    ),
  );

  // Data Sources
  getIt.registerLazySingleton<BrowseRemoteDataSource>(
    () => BrowseRemoteDataSourceImpl(getIt<ApiManager>()),
  );
  getIt.registerLazySingleton<BrowseFirebaseDataSource>(
    () => BrowseFirebaseDataSourceImpl(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ),
  );

// Repository
  getIt.registerLazySingleton<BrowseRepository>(
    () => BrowseRepositoryImpl(
      remoteDataSource: getIt<BrowseRemoteDataSource>(),
      firebaseDataSource: getIt<BrowseFirebaseDataSource>(),
    ),
  );

// Cubit
  getIt.registerFactory<BrowseCubit>(
    () => BrowseCubit(getIt<BrowseRepository>()),
  );

}

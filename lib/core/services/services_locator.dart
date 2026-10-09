import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/features/browse/data/datasources/browse_firebase_data_source.dart';
import 'package:movies_app/features/browse/data/datasources/browse_remote_data_source.dart';
import 'package:movies_app/features/browse/data/repositories/browse_repository_impl.dart';
import 'package:movies_app/features/browse/domain/repositories/browse_repository.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_cubit.dart';
import 'package:movies_app/features/home/data/datasources/movie_remote_data_source.dart';
import 'package:movies_app/features/home/data/repositories/movie_repository_impl.dart';
import 'package:movies_app/features/home/domain/repositories/movie_repository.dart';
import 'package:movies_app/features/home/domain/usecases/get_movies_usecase.dart';
import 'package:movies_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:movies_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repo_implementation.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:movies_app/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:movies_app/features/profile/presentation/manager/profile_cubit.dart';
import '../network/api_manager.dart';

final getIt = GetIt.instance;

void servicesLocator() {
  getIt.registerLazySingleton<ApiManager>(() => ApiManager());

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

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepoImplementation(getIt()),
  );

  getIt.registerLazySingleton(() => UpdateProfileUsecase(getIt()));

  getIt.registerLazySingleton(() => DeleteAccountUsecase(getIt()));

  getIt.registerFactory(
    () => ProfileCubit(
      updateProfileUsecase: getIt(),
      deleteAccountUseCase: getIt(),
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
    () => BrowseCubit(getIt<BrowseRepository>())..loadBrowseData(),
  );
}

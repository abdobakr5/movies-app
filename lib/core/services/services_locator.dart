import 'package:get_it/get_it.dart';
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
import 'package:movies_app/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:movies_app/features/movie_details/data/repositories/movie_details_repository_impl.dart';
import 'package:movies_app/features/movie_details/domain/repositories/movie_details_repository.dart';
import 'package:movies_app/features/movie_details/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/features/movie_details/domain/usecases/get_movie_suggestions_usecase.dart';
import 'package:movies_app/features/movie_details/presentation/cubit/movie_details_cubit.dart';

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

  // Movie Details
  getIt.registerLazySingleton<MovieDetailsRemoteDataSource>(
    () => MovieDetailsRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<MovieDetailsRepository>(
    () => MovieDetailsRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<GetMovieDetailsUseCase>(
    () => GetMovieDetailsUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetMovieSuggestionsUseCase>(
    () => GetMovieSuggestionsUseCase(getIt()),
  );

  getIt.registerFactory<MovieDetailsCubit>(
    () => MovieDetailsCubit(
      getMovieDetailsUseCase: getIt(),
      getMovieSuggestionsUseCase: getIt(),
    ),
  );
}

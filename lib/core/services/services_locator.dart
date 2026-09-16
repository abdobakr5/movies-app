import 'package:get_it/get_it.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/domain/repositories/profile_repo_implementation.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/profile/domain/usecases/delete_account_usecase.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';

import '../../features/home/data/datasources/movie_remote_data_source.dart';
import '../../features/home/data/repositories/movie_repository_impl.dart';
import '../../features/home/domain/repositories/movie_repository.dart';
import '../../features/home/domain/usecases/get_movies_usecase.dart';

import '../network/api_manager.dart';

final getIt = GetIt.instance;

void ServicesLocator() {
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
}

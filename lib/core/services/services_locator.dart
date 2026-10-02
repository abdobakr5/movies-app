import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:movies_app/features/profile/domain/usecases/history_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/logout_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/wishlist_usecase.dart';
import 'package:movies_app/features/profile/presentation/manager/profile_cubit.dart';
import '../network/api_manager.dart';

final getIt = GetIt.instance;

void servicesLocator() {

  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);


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
    () => ProfileRemoteDataSourceImpl(
      firestore:getIt(),auth:getIt()
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepoImplementation(getIt()),
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
  
}

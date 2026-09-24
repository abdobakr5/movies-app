import 'package:get_it/get_it.dart';
import 'package:movies_app/features/profile/domain/usecases/get_user_data_usecase.dart';

import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/domain/repositories/profile_repo_implementation.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/profile/domain/usecases/delete_account_usecase.dart';
import '../../features/profile/presentation/manager/profile_cubit.dart';

final getIt=GetIt.instance;
//this is the main function where we register all the classes 
void ServicesLocator(){
  getIt.registerLazySingleton<ProfileRemoteDataSource>(()=>ProfileRemoteDataSource());
  getIt.registerLazySingleton<ProfileRepository>(()=>ProfileRepoImplementation(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUsecase(getIt()));
  getIt.registerLazySingleton(() => DeleteAccountUsecase(getIt()));
  getIt.registerLazySingleton(()=> GetUserDataUsecase(getIt()));
  getIt.registerFactory(() => ProfileCubit(
    updateProfileUsecase: getIt(),
    deleteAccountUseCase: getIt(),
    getUserDataUsecase: getIt(),
  ));



}

import 'package:movies_app/features/movies/domain/entities/user_entity.dart';
import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';

class  GetUserDataUsecase {
  final ProfileRepository repository;
  GetUserDataUsecase(this.repository);

  Future<UserEntity> call() async{
    return await repository.getUserData();
  }
}
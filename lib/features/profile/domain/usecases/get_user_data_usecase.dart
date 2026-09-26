import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class  GetUserDataUsecase {
  final ProfileRepository repository;
  GetUserDataUsecase(this.repository);

  Future<UserEntity> call() async{
    return await repository.getUserData();
  }
}
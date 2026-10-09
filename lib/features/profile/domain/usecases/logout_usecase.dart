import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class LogoutUsecase {
  final ProfileRepository repository;
  LogoutUsecase(this.repository);
  Future<void> call() async{
    return await repository.logout();
  }
}
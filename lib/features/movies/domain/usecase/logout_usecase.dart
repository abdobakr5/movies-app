import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';

class LogoutUsecase {
  final ProfileRepository repository;
  LogoutUsecase(this.repository);
  Future<void> call() async{
    return await repository.logout();
  }
}
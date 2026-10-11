import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';

class DeleteAccountUsecase {
  final ProfileRepository repository;
  DeleteAccountUsecase(this.repository);
  Future<void> call() async {
    return await repository.deleteAccount();
  }
}

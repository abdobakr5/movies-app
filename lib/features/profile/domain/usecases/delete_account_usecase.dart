import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class DeleteAccountUsecase {
  final ProfileRepository repository;
  DeleteAccountUsecase(this.repository);
  Future<void> call() async {
    return await repository.deleteAccount();
  }
}

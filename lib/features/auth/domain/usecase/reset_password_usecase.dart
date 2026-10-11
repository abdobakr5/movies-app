import 'package:movies_app/features/auth/domain/repository/auth_repo.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call(String email) {
    return repository.resetPassword(email);
  }
}

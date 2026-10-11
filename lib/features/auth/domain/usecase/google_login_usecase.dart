import 'package:movies_app/features/auth/domain/repository/auth_repo.dart';

class GoogleLoginUseCase {
  final AuthRepository repository;

  GoogleLoginUseCase(this.repository);

  Future<void> call() {
    return repository.loginWithGoogle();
  }
}

import 'package:movies_app/features/auth/domain/repository/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<void> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}

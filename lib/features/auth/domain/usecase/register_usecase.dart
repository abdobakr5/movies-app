import 'package:movies_app/features/auth/domain/repository/auth_repo.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) {
    return repository.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );
  }
}

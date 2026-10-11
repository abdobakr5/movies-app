import 'package:movies_app/features/auth/data/repository/data_source/auth_remote_data_source.dart';
import 'package:movies_app/features/auth/domain/repository/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) {
    return remoteDataSource.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );
  }

  @override
  Future<void> login({required String email, required String password}) {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> loginWithGoogle() {
    return remoteDataSource.loginWithGoogle();
  }

  @override
  Future<void> resetPassword(String email) {
    return remoteDataSource.resetPassword(email);
  }
}

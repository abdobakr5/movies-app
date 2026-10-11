abstract class AuthRepository {
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  });

  Future<void> login({required String email, required String password});

  Future<void> loginWithGoogle();

  Future<void> resetPassword(String email);
}

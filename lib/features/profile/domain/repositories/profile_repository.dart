abstract class ProfileRepository {
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  });
  Future<void> deleteAccount();
}

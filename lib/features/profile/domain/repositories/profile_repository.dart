abstract class ProfileRepository {
Future<void> UpdateProfile({
  required String name,
  required String phone,
  required String avatar,
});
Future<void>deleteAccount();
}

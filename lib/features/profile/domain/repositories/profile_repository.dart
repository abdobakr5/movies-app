import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
Future<void> updateProfile({
  required String name,
  required String phone,
  required String avatar,
});
Future<void>deleteAccount();
Future<UserEntity> getUserData();
}

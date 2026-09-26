import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
Future<void> UpdateProfile({
  required String name,
  required String phone,
  required String avatar,
});
Future<void>deleteAccount();
Future<UserEntity> getUserData();
}

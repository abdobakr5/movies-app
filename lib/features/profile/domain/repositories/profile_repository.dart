import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
Future<void> updateProfile({
  required String name,
  required String phone,
  required String avatar,
});
Future<void>deleteAccount();
Future<UserEntity> getUserData();
Future<void>logout();

Future<List<MovieEntity>>getWishlist();
Future<List<MovieEntity>>getHistory();

}


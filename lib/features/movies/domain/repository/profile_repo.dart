import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/entities/user_entity.dart';

abstract class ProfileRepository {
Future<void> updateProfile({
  required String name,
  required String phone,
  required int avatarIndex,
});
Future<void>deleteAccount();
Future<UserEntity> getUserData();
Future<void>logout();

Future<List<MovieEntity>>getWishlist();
Future<List<MovieEntity>>getHistory();

}


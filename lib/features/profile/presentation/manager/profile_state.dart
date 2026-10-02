import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileIntial extends ProfileState {}

class ProfileLoading extends ProfileState {}

  class ProfileSuccess extends ProfileState{
    final UserEntity? user;
    ProfileSuccess([this.user]);
    
  }

class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class LogoutLoading extends ProfileState{}
class LogoutSuccess extends ProfileState{}
class LogoutError extends ProfileState {
  final String message;
  LogoutError(this.message);
}
class  ProfileWishlistAndHistoryLoaded extends ProfileState{
  final List<MovieEntity> wishlist;
  final List<MovieEntity> history;

  ProfileWishlistAndHistoryLoaded({
    required this.wishlist,
    required this.history,
  });


}


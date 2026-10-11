import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/data/repository/data_source/profile_remote_data_source.dart';
import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';
import 'package:movies_app/features/movies/domain/entities/user_entity.dart';

class ProfileRepoImplementation implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepoImplementation(this.remoteDataSource);

  @override
  Future<void> updateProfile(
      {required String name,
      required String phone,
      required int avatarIndex}) async {
    await remoteDataSource.excuteAccountAction(
      isDelete: false,
      name: name,
      phone: phone,
      avatarIndex: avatarIndex,
    );
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.excuteAccountAction(
      isDelete: true,
    );
  }
  @override
  Future<UserEntity>getUserData() async{
    return await remoteDataSource.getUserData();
  }
  @override
  Future<void> logout() async{
    await remoteDataSource.logout();
    
  }
  @override
Future<List<MovieEntity>> getWishlist() async{
  final remoteWishlist=await remoteDataSource.getWishlist();
return remoteWishlist.map((movieModel)=>movieModel.toEntity()).toList();
}

 @override
 Future<List<MovieEntity>>getHistory() async{
  final remoteHistory=await remoteDataSource.getHistory();
  return remoteHistory.map((model)=> model.toEntity()).toList();
 }

}

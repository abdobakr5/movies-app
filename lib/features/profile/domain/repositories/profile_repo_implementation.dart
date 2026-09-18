import 'package:movies_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepoImplementation implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepoImplementation(this.remoteDataSource);
  @override
  Future<void> updateProfile(
      {required String name,
      required String phone,
      required String avatar}) async {
    await remoteDataSource.excuteAccountAction(
      isDelete: false,
      name: name,
      phone: phone,
      avatar: avatar,
    );
  }

  @override
  Future<void> deleteAccount() async {
    await remoteDataSource.excuteAccountAction(
      isDelete: true,
    );
  }
}

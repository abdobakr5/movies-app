import 'package:movies_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

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

  Future<UserEntity>getUserData() async{
    String uid=FirebaseAuth.instance.currentUser?.uid??'';
    var doc =await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var data=doc.data() as Map<String,dynamic>;
    return UserEntity(name: data['name'], phone: data['phone']);
  }

}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';
import 'package:movies_app/features/movies/domain/entities/user_entity.dart';


abstract class ProfileRemoteDataSource {
  Future<List<MovieModel>> getWishlist();
  Future<List<MovieModel>> getHistory();
  Future<void> logout();
  Future<UserEntity> getUserData();
  Future<void> excuteAccountAction({
    required bool isDelete,
    String?name,
    String?phone,
    int?avatarIndex,

  });
}
   
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ProfileRemoteDataSourceImpl({

    
    required this.auth,
    required this.firestore
    });

    @override
     Future<void> excuteAccountAction({
    // IsDelete function => to know we will update or delete.
    required bool isDelete,
    String?name,
    String?phone,
    int?avatarIndex,
   })async{
    final user=auth.currentUser;
    // Guard Clause 
    if(user==null)throw Exception("No User Loged In");
    final userRef=firestore.collection('users').doc(user.uid);
    if(isDelete){
    // if variable of(isDelete) is true => this is meaning that the user click on delete button.
      await userRef.delete();
    // delete the account from FirebaseAuth
      await user.delete();
    }
    else{
    // if is delete is false this is meaning that the user click on update button.
    //and send the updated data to firestore
      await userRef.update({
        'name':name??'',
        'phone':phone??'',
        'avatarIndex':avatarIndex??0,
      });
      if(name!=null){
        
        await user.updateDisplayName(name);
      }
    }
   }


    @override
    Future<List<MovieModel>>getHistory()async{
    final userId=auth.currentUser?.uid;
    final result=await firestore.
    collection('users').
    doc(userId).
    collection('history'). 
    get();
    return result.docs.map((doc) => MovieModel.fromJson(doc.data())).toList();
   }

    @override
   Future<List<MovieModel>> getWishlist()async {
    final userId=auth.currentUser?.uid;
    final result=await firestore.
    collection('users').
    doc(userId).
    collection('wishlist'). 
    get();
    return result.docs.map((doc) => MovieModel.fromJson(doc.data())).toList();
   }

   @override
    Future<void>logout()async{
    await auth.signOut();
   }

   @override
    Future<UserEntity> getUserData() async {
    final doc = await firestore.collection('users').doc(auth.currentUser?.uid).get();
    final data = doc.data()!;
    return UserEntity(
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      avatarIndex: data['avatarIndex'] ?? 0,
    );
   }
  
}

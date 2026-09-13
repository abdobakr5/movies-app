import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRemoteDataSource {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  // I will use A unified function for profile operation
   Future<void> excuteAccountAction({
    // IsDelete function => to know we will update or delete.
    required bool isDelete,
    String?name,
    String?phone,
    String?avatar,
   })async{
    final user=_auth.currentUser;
    // Guard Clause 
    if(user==null)throw Exception("No User Loged In");
    final userRef=_firestore.collection('users').doc(user.uid);
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
        'avatar':avatar??'',
      });
      if(name!=null){
        
        await user.updateDisplayName(name);
      }
    }
   }

  
}
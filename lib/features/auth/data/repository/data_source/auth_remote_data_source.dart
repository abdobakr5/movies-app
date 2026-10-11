import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource({required this.auth, required this.firestore});

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      uid: result.user!.uid,
      name: name,
      email: email,
      phone: phone,
      avatarIndex: avatarIndex,
    );

    await firestore.collection('users').doc(user.uid).set(user.toFirestore());
  }

  Future<void> login({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> loginWithGoogle() async {
    await GoogleSignIn.instance.initialize();
    final account = await GoogleSignIn.instance.authenticate();

    final credential = GoogleAuthProvider.credential(
      idToken: account.authentication.idToken,
    );
    final result = await auth.signInWithCredential(credential);

    final doc = firestore.collection('users').doc(result.user!.uid);
    if ((await doc.get()).exists) return;

    final user = UserModel(
      uid: result.user!.uid,
      name: account.displayName ?? '',
      email: account.email,
      phone: '',
      avatarIndex: 1,
    );
    await doc.set(user.toFirestore());
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}

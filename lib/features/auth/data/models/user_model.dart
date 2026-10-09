import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final int avatarIndex;
  final FieldValue? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarIndex,
    this.createdAt,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarIndex': avatarIndex,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
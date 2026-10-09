// lib/features/browse/data/datasources/browse_firebase_data_source.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../home/data/models/movie_model.dart';

abstract class BrowseFirebaseDataSource {
  Future<void> addToHistory(MovieModel movie);
}

class BrowseFirebaseDataSourceImpl implements BrowseFirebaseDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  BrowseFirebaseDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<void> addToHistory(MovieModel movie) async {
    final user = auth.currentUser;
    if (user == null) return;

    final historyDocRef = firestore
        .collection('users')
        .doc(user.uid)
        .collection('history')
        .doc(movie.id.toString());

    await historyDocRef.set({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.largeCoverImage,
      'rating': movie.rating,
      'visitedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';

class WatchlistRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WatchlistRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>>? _getUserWatchlistRef() {
    final uid = _currentUserId;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid).collection('watchlist');
  }

  Future<bool> isBookmarked(int movieId) async {
    final watchlistRef = _getUserWatchlistRef();
    if (watchlistRef == null) return false;

    try {
      final docSnapshot = await watchlistRef.doc(movieId.toString()).get();
      return docSnapshot.exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> addBookmark(MovieDetailsEntity movie) async {
    final watchlistRef = _getUserWatchlistRef();
    if (watchlistRef == null) {
      throw Exception('User is not logged in');
    }

    await watchlistRef.doc(movie.id.toString()).set({
      'movieId': movie.id,
      'title': movie.title,
      'year': movie.year,
      'rating': movie.rating,
      'runtime': movie.runtime,
      'likeCount': movie.likeCount,
      'summary': movie.summary,
      'descriptionFull': movie.descriptionFull,
      'mediumCoverImage': movie.mediumCoverImage,
      'largeCoverImage': movie.largeCoverImage,
      'genres': movie.genres,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeBookmark(int movieId) async {
    final watchlistRef = _getUserWatchlistRef();
    if (watchlistRef == null) {
      throw Exception('User is not logged in');
    }

    await watchlistRef.doc(movieId.toString()).delete();
  }

  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final watchlistRef = _getUserWatchlistRef();
    if (watchlistRef == null) return [];

    final querySnapshot =
        await watchlistRef.orderBy('createdAt', descending: true).get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}

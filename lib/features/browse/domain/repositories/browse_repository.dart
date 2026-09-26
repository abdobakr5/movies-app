import '../../../home/data/models/movie_model.dart';

abstract class BrowseRepository {
  /// جلب قائمة الأفلام الأساسية من الـ API
  Future<List<MovieModel>> getMovies();

  /// إرسال الفيلم المزار إلى Firestore History
  Future<void> addToHistory(MovieModel movie);
}

import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';

abstract class BrowseRepository {
  /// جلب قائمة الأفلام الأساسية من الـ API
  Future<List<MovieEntity>> getMovies();

  /// إرسال الفيلم المزار إلى Firestore History
  Future<void> addToHistory(MovieEntity movie);
}

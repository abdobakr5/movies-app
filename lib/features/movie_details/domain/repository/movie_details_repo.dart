import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);
  Future<List<MovieEntity>> getMovieSuggestions(int movieId);
  Future<bool> isBookmarked(int movieId);
  Future<void> addBookmark(MovieDetailsEntity movie);
  Future<void> removeBookmark(int movieId);
}

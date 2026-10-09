import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);
  Future<List<MovieEntity>> getMovieSuggestions(int movieId);
}

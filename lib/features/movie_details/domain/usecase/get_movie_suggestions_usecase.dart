import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/domain/repository/movie_details_repo.dart';

class GetMovieSuggestionsUseCase {
  final MovieDetailsRepository repository;

  GetMovieSuggestionsUseCase(this.repository);

  Future<List<MovieEntity>> call(int movieId) {
    return repository.getMovieSuggestions(movieId);
  }
}

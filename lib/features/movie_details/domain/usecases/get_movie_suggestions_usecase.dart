import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/domain/repositories/movie_details_repository.dart';

class GetMovieSuggestionsUseCase {
  final MovieDetailsRepository repository;

  GetMovieSuggestionsUseCase(this.repository);

  Future<List<MovieEntity>> call(int movieId) {
    return repository.getMovieSuggestions(movieId);
  }
}

import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/movie_repo.dart';

class GetMoviesUseCase {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call({
    String? query,
    String? genre,
  }) {
    return repository.getMovies(
      query: query,
      genre: genre,
    );
  }
}

import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/browse_repo.dart';

class GetBrowseMoviesUseCase {
  final BrowseRepository repository;

  GetBrowseMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call() {
    return repository.getMovies();
  }
}

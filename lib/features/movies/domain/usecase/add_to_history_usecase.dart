import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/browse_repo.dart';

class AddToHistoryUseCase {
  final BrowseRepository repository;

  AddToHistoryUseCase(this.repository);

  Future<void> call(MovieEntity movie) {
    return repository.addToHistory(movie);
  }
}

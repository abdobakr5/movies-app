import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/movie_details/domain/repository/movie_details_repo.dart';

class SaveToHistoryUseCase {
  final MovieDetailsRepository repository;

  SaveToHistoryUseCase(this.repository);

  Future<void> call(MovieDetailsEntity movie) {
    return repository.addToHistory(movie);
  }
}

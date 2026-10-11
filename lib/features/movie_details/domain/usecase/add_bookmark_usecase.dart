import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/movie_details/domain/repository/movie_details_repo.dart';

class AddBookmarkUseCase {
  final MovieDetailsRepository repository;

  AddBookmarkUseCase(this.repository);

  Future<void> call(MovieDetailsEntity movie) {
    return repository.addBookmark(movie);
  }
}

import 'package:movies_app/features/movie_details/domain/repository/movie_details_repo.dart';

class RemoveBookmarkUseCase {
  final MovieDetailsRepository repository;

  RemoveBookmarkUseCase(this.repository);

  Future<void> call(int movieId) {
    return repository.removeBookmark(movieId);
  }
}

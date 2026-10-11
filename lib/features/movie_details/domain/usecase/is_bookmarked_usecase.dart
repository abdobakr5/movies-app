import 'package:movies_app/features/movie_details/domain/repository/movie_details_repo.dart';

class IsBookmarkedUseCase {
  final MovieDetailsRepository repository;

  IsBookmarkedUseCase(this.repository);

  Future<bool> call(int movieId) {
    return repository.isBookmarked(movieId);
  }
}

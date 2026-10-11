import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/data/repository/data_source/movie_details_remote_data_source.dart';
import 'package:movies_app/features/movie_details/data/repository/data_source/watchlist_remote_data_source.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/movie_details/domain/repository/movie_details_repo.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;
  final WatchlistRemoteDataSource watchlistDataSource;

  MovieDetailsRepositoryImpl(this.remoteDataSource, this.watchlistDataSource);

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) {
    return remoteDataSource.getMovieDetails(movieId);
  }

  @override
  Future<List<MovieEntity>> getMovieSuggestions(int movieId) {
    return remoteDataSource.getMovieSuggestions(movieId);
  }

  @override
  Future<bool> isBookmarked(int movieId) {
    return watchlistDataSource.isBookmarked(movieId);
  }

  @override
  Future<void> addBookmark(MovieDetailsEntity movie) {
    return watchlistDataSource.addBookmark(movie);
  }

  @override
  Future<void> removeBookmark(int movieId) {
    return watchlistDataSource.removeBookmark(movieId);
  }
}

import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:movies_app/features/movie_details/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/movie_details/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) {
    return remoteDataSource.getMovieDetails(movieId);
  }

  @override
  Future<List<MovieEntity>> getMovieSuggestions(int movieId) {
    return remoteDataSource.getMovieSuggestions(movieId);
  }
}

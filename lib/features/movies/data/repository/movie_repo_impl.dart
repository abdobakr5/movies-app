import 'package:movies_app/features/movies/data/repository/data_source/movie_remote_data_source.dart';
import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/movie_repo.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieEntity>> getMovies({
    String? query,
    String? genre,
  }) {
    return remoteDataSource.getMovies(
      query: query,
      genre: genre,
    );
  }
}

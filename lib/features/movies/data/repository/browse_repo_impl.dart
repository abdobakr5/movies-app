import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/browse_repo.dart';
import 'package:movies_app/features/movies/data/repository/data_source/browse_remote_data_source.dart';
import 'package:movies_app/features/movies/data/repository/data_source/browse_firebase_data_source.dart';

class BrowseRepositoryImpl implements BrowseRepository {
  final BrowseRemoteDataSource remoteDataSource;
  final BrowseFirebaseDataSource firebaseDataSource;

  BrowseRepositoryImpl({
    required this.remoteDataSource,
    required this.firebaseDataSource,
  });

  @override
  Future<List<MovieEntity>> getMovies() async {
    return await remoteDataSource.getMovies();
  }

  @override
  Future<void> addToHistory(MovieEntity movie) async {
    await firebaseDataSource.addToHistory(movie);
  }
}

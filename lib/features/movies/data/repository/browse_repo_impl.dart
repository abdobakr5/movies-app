import 'package:movies_app/features/movies/domain/repository/browse_repo.dart';
import 'package:movies_app/features/movies/data/repository/data_source/browse_remote_data_source.dart';
import 'package:movies_app/features/movies/data/repository/data_source/browse_firebase_data_source.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';

class BrowseRepositoryImpl implements BrowseRepository {
  final BrowseRemoteDataSource remoteDataSource;
  final BrowseFirebaseDataSource firebaseDataSource;

  BrowseRepositoryImpl({
    required this.remoteDataSource,
    required this.firebaseDataSource,
  });

  @override
  Future<List<MovieModel>> getMovies() async {
    return await remoteDataSource.getMovies();
  }

  @override
  Future<void> addToHistory(MovieModel movie) async {
    await firebaseDataSource.addToHistory(movie);
  }
}

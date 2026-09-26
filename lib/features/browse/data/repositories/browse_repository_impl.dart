import '../../domain/repositories/browse_repository.dart';
import '../datasources/browse_remote_data_source.dart';
import '../datasources/browse_firebase_data_source.dart';
import '../../../home/data/models/movie_model.dart';

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

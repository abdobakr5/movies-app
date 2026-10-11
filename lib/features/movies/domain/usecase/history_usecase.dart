import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';

class GetHistoryUsecase {
  final ProfileRepository repository;
  GetHistoryUsecase(this.repository);

  Future<List<MovieEntity>> call() async{
    return await repository.getHistory();
  }
}
import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class GetHistoryUsecase {
  final ProfileRepository repository;
  GetHistoryUsecase(this.repository);

  Future<List<MovieEntity>> call() async{
    return await repository.getHistory();
  }
}
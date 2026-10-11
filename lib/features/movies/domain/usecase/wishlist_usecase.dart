import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';

class GetWishlistUsecase{
    final ProfileRepository repository;
    GetWishlistUsecase(this.repository);

    Future<List<MovieEntity>> call() async{
        return await repository.getWishlist();
    }
}
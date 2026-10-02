import 'package:movies_app/features/home/domain/entities/movie_entity.dart';
import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class GetWishlistUsecase{
    final ProfileRepository repository;
    GetWishlistUsecase(this.repository);

    Future<List<MovieEntity>> call() async{
        return await repository.getWishlist();
    }
}
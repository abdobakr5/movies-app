import 'package:movies_app/features/movies/domain/repository/profile_repo.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;
  UpdateProfileUsecase(this.repository);
  Future<void> call({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    return await repository.updateProfile(
        name: name, phone: phone, avatarIndex: avatarIndex);
  }
}

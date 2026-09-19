import 'package:movies_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUsecase {
  final ProfileRepository repository;
  UpdateProfileUsecase(this.repository);
  Future<void> call({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    return await repository.updateProfile(
        name: name, phone: phone, avatar: avatar);
  }
}

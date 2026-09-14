import '../repositories/profile_repository.dart';
class UpdateProfileUsecase {
  final ProfileRepository repository;
  UpdateProfileUsecase(this.repository);
  Future<void>call({
    required String name,
    required String phone,
    required String avatar,
  })async{
    return await repository.UpdateProfile(
      name: name, 
      phone: phone, 
      avatar: avatar);
  }
}
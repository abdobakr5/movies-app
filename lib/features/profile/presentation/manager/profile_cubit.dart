import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;
  final DeleteAccountUsecase deleteAccountUseCase;

  ProfileCubit(
      {required this.updateProfileUsecase, required this.deleteAccountUseCase})
      : super(ProfileIntial());

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(ProfileLoading());
    try {
      await updateProfileUsecase.call(
        name: name,
        phone: phone,
        avatar: avatar,
      );
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileLoading());
    try {
      await deleteAccountUseCase();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

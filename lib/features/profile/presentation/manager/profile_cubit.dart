import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/history_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/logout_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/get_user_data_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/wishlist_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUsecase updateProfileUsecase;
  final DeleteAccountUsecase deleteAccountUseCase;
  final GetUserDataUsecase getUserDataUsecase;
  final LogoutUsecase logoutUsecase;
  final GetWishlistUsecase getWishlistUsecase;
  final GetHistoryUsecase getHistoryUseCase;
  

  ProfileCubit({
    required this.updateProfileUsecase,
    required this.deleteAccountUseCase,
    required this.getUserDataUsecase,
    required this.logoutUsecase,
    required this.getHistoryUseCase,
    required this.getWishlistUsecase,
  }) : super(ProfileIntial());

  void fetchUserData()async{
    emit(ProfileLoading());
    try {
      var user =await getUserDataUsecase();
      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

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
  Future<void> logout() async{
   emit(ProfileLoading());
   try {
     await logoutUsecase();
     emit(LogoutSuccess());
   } catch (e) {
    emit(ProfileError(e.toString()));
     
   }
  }
  Future<void> getWishlistAndHistory() async{
    emit(ProfileLoading());
    try {
      final wishList= await getWishlistUsecase();
      final history=await getHistoryUseCase();

      emit(ProfileWishlistAndHistoryLoaded(wishlist: wishList, history: history));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}

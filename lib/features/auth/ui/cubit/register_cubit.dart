import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/usecase/register_usecase.dart';
import 'package:movies_app/features/auth/ui/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  int selectedAvatarIndex = 1;

  void selectAvatar(int index) {
    selectedAvatarIndex = index;
    emit(RegisterAvatarChanged(selectedAvatarIndex));
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoading());

    try {
      await registerUseCase(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatarIndex: selectedAvatarIndex,
      );

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(e.message ?? 'Authentication failed'));
    } catch (e) {
      emit(RegisterFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

final class RegisterFailure extends RegisterState {
  final String errorMessage;
  RegisterFailure(this.errorMessage);
}

final class RegisterAvatarChanged extends RegisterState {
  final int selectedAvatarIndex;
  RegisterAvatarChanged(this.selectedAvatarIndex);
}
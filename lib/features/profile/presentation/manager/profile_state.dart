

import 'package:flutter/material.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileState {}

  class ProfileIntial extends ProfileState{}
  
  class ProfileLoading extends ProfileState{}

  class ProfileSuccess extends ProfileState{
    final UserEntity? user;
    ProfileSuccess([this.user]);
    
  }

  class ProfileDeleted extends ProfileState{}

  class ProfileError extends ProfileState{
    final String message;
    ProfileError(this.message);
}

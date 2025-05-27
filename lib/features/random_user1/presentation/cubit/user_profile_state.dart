
import '../../domain/entities/user_profile.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserProfile1 profile;

  UserProfileLoaded(this.profile);
}

class UserProfileError extends UserProfileState {
  final String message;

  UserProfileError(this.message);
}

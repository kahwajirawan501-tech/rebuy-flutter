abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String message;

  ProfileSuccess(this.message);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}


       /// SIGN OUT STATE
class ProfileSignOutLoading extends ProfileState {}

class ProfileSignOutSuccess extends ProfileState {
  final String message;

  ProfileSignOutSuccess(this.message);
}

class ProfileSignOutError extends ProfileState {
  final String message;

  ProfileSignOutError(this.message);
}

/// CHANGE PASSWORD
class ProfileChangePasswordLoading extends ProfileState {}

class ProfileChangePasswordSuccess extends ProfileState {
  final String message;

  ProfileChangePasswordSuccess(this.message);
}

class ProfileChangePasswordError extends ProfileState {
  final String message;

  ProfileChangePasswordError(this.message);
}

/// UPDATE PROFILE
class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final String message;
final String? image;
  UpdateProfileSuccess(this.message, this.image);
}

class UpdateProfileError extends ProfileState {
  final String message;

  UpdateProfileError(this.message);
}
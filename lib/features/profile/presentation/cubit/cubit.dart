
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/auth/data/models/user_model.dart';
import 'package:roasters/features/profile/data/mappers/update_profile_builder.dart';
import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';
import 'package:roasters/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:roasters/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:roasters/features/profile/domain/usecases/upload_image_profile_usecase.dart';
import 'package:roasters/features/profile/presentation/cubit/state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthLocalDataSource authLocalDataSource;
  final ChangePasswordUseCase changePasswordUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadImageProfileUseCase uploadImageProfileUseCase;
  ProfileCubit(this.authLocalDataSource, this.changePasswordUseCase, this.updateProfileUseCase, this.uploadImageProfileUseCase) : super(ProfileInitial());

  Future<void> signOut() async {
    emit(ProfileSignOutLoading());

    try {
      await authLocalDataSource.clearToken();

      emit(ProfileSignOutSuccess("profile_page_sign_out_success"));
    } catch (e) {
      emit(ProfileSignOutError("profile_page_sign_out_error"));
    }
  }
  Future<void> changePassWord({required String oldPassword,required String newPassword})
  async {
    emit(ProfileChangePasswordLoading());
    try {
      final email = await authLocalDataSource.getEmail();

      if (email == null) {
        emit(ProfileChangePasswordError("profile_page_email_not_found"));
        return;
      }

      await changePasswordUseCase(
        email: email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      emit(ProfileChangePasswordSuccess("profile_page_change_password_success"));
    } catch (e) {
      emit(ProfileChangePasswordError("profile_page_change_password_error"));
    }
  }
  Future<void> removeLocalProfileImage() async {
    try {
      final user = await authLocalDataSource.getUser();
      if (user == null) return;

      final updatedUser = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        profileImage: null,
        role: user.role,
        isActive: user.isActive,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
      );

      await authLocalDataSource.saveUser(updatedUser);

    } catch (e) {

    }
  }
  Future<void> updateProfile(UpdateProfileEntity profile, File? image) async {
    emit(UpdateProfileLoading());
    try {
      String? imagePath;

      // 1️⃣ رفع الصورة إذا موجودة
      if (image != null) {
        final path = await uploadImageProfileUseCase(file: image);
        imagePath = path.path;
      }

      final updateEntity = await UpdateProfileBuilder.build(
        old: authLocalDataSource,
        current: profile,
        newImage: imagePath,
      );

      final oldUser = await authLocalDataSource.getUser();
      final updatedUser =
      await updateProfileUseCase(product: updateEntity);

      final newUser = UserModel(
        id: oldUser!.id,
        email: oldUser.email,
        role: oldUser.role,
        updatedAt: oldUser.updatedAt,
        createdAt: oldUser.createdAt,
        isActive: oldUser.isActive,
        name: updatedUser.name,
        phone: updatedUser.phone,
        profileImage: updatedUser.profileImage,
      );
      await authLocalDataSource.saveUser(newUser);
      emit(UpdateProfileSuccess(
        "profile_page_update_success",
        newUser.profileImage,
      ));    } catch (e) {
      emit(UpdateProfileError("profile_page_update_error"));
    }
  }
}
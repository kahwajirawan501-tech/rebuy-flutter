import 'dart:io';

import 'package:roasters/features/profile/domain/entities/image_upload_entity.dart';
import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';
import 'package:roasters/features/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<String>changePassword(
      {required String email,required String oldPassword,required String newPassword});
  Future<UserProfileEntity> updateProfile({
    required UpdateProfileEntity product,
  });
  Future <ImageUploadEntity> imageUpload({required File file});

}
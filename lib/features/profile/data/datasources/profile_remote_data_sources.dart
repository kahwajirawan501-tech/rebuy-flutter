import 'dart:io';

import 'package:dio/dio.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/profile/data/models/image_upload_model.dart';
import 'package:roasters/features/profile/data/models/update_profile_request_model.dart';
import 'package:roasters/features/profile/data/models/user_profile_model.dart';

abstract class ProfileRemoteDataSources {
  Future<String>changePassword({
    required String email,required String oldPassword,required String newPassword});
  Future<UserProfileModel> updateProfile({
    required UpdateProfileRequestModel product,
  });
  Future <ImageUploadModel>imageUpload({required File file});

}
class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSources{
  final Dio dio;

  ProfileRemoteDataSourcesImpl(this.dio);

  @override
  Future<String> changePassword({required String email,required String oldPassword,required String newPassword})async {
    try{
      final response=await dio.post(
        "/auth/change-password",
        data: {
          "email":email,
          "oldPassword":oldPassword,
          "newPassword":newPassword
        }
      );
      return response.data['message'];
    }on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }

  }

  @override
  Future<UserProfileModel> updateProfile({required UpdateProfileRequestModel product})async {
    try{
      final response=await dio.patch(
          "/user/update",
          data:product.toJson()
      );
      return UserProfileModel.fromJson(response.data['data']);
    }on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }
  @override
  Future<ImageUploadModel> imageUpload({required File file}) async {
    FormData formData = FormData(

    );
      formData.files.add(
        MapEntry(
          "file",
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    try {
      final response = await dio.post(
        "/upload/profile-image",
        data: formData,

      );

      return ImageUploadModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

}
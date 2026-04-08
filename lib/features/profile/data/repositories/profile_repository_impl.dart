import 'dart:io';

import 'package:roasters/features/profile/data/datasources/profile_remote_data_sources.dart';
import 'package:roasters/features/profile/data/mappers/image_upload_mapper.dart';
import 'package:roasters/features/profile/data/mappers/update_profile_request_mapper.dart';
import 'package:roasters/features/profile/data/mappers/user_profile_mapper.dart';
import 'package:roasters/features/profile/domain/entities/image_upload_entity.dart';
import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';
import 'package:roasters/features/profile/domain/entities/user_profile_entity.dart';
import 'package:roasters/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDataSources profileRemoteDataSources;

  ProfileRepositoryImpl(this.profileRemoteDataSources);
  @override
  Future<String> changePassword
      ({required String email, required String oldPassword, required String newPassword}) async{
    final response=await profileRemoteDataSources.
    changePassword(email: email, oldPassword: oldPassword, newPassword: newPassword);
    return response;
  }

  @override
  Future<UserProfileEntity> updateProfile({required UpdateProfileEntity product})async {
    final profileModel=product.toModel();
    final response= await profileRemoteDataSources.updateProfile(product: profileModel);
    return response.toEntity();

  }
  @override
  Future<ImageUploadEntity> imageUpload({required File file}) async {
    final models = await profileRemoteDataSources.imageUpload(file: file);
    return models.toEntity();
  }


}
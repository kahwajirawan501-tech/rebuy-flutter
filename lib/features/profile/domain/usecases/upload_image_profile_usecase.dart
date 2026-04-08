import 'dart:io';

import 'package:roasters/features/profile/domain/entities/image_upload_entity.dart';
import 'package:roasters/features/profile/domain/repositories/profile_repository.dart';

class UploadImageProfileUseCase {
  final ProfileRepository profileRepository;

  UploadImageProfileUseCase(this.profileRepository);
  Future<ImageUploadEntity>call({required File file})async{
    return await profileRepository.imageUpload(file: file);
  }
}
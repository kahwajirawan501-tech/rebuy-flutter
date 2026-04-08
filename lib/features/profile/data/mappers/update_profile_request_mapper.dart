import 'package:roasters/features/profile/data/models/update_profile_request_model.dart';
import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';

extension UpdateProfileRequestMapper on UpdateProfileEntity{
  UpdateProfileRequestModel toModel(){
    return UpdateProfileRequestModel(name: name, phone: phone, images: image);
  }
}
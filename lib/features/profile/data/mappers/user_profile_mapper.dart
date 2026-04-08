import 'package:roasters/features/profile/data/models/user_profile_model.dart';
import 'package:roasters/features/profile/domain/entities/user_profile_entity.dart';

extension UserProfileMapper on UserProfileModel{
  UserProfileEntity toEntity(){
    return UserProfileEntity(id: id,
        name: name,
        email: email, phone: phone, profileImage: profileImage, role: role);
  }
}
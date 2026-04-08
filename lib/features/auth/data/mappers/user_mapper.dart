import 'package:roasters/features/auth/domain/entities/user_entity.dart';

import '../models/user_model.dart';

extension UserMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      profileImage: profileImage,
      role: role,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
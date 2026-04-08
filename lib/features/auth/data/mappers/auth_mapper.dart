import '../../domain/entities/auth_entity.dart';
import '../models/auth_model.dart';
import 'user_mapper.dart';

extension AuthMapper on AuthModel {
  AuthEntity toEntity() {
    return AuthEntity(
      user: user.toEntity(),
      accessToken: accessToken,
    );
  }
}
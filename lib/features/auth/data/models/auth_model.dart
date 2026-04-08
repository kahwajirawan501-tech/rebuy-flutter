import 'package:roasters/features/auth/data/models/user_model.dart';

class AuthModel {
  final UserModel user;
  final String accessToken;

  AuthModel({
    required this.user,
    required this.accessToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      user: UserModel.fromJson(json['data']['user']),
      accessToken: json['data']['access_token'],
    );
  }
}
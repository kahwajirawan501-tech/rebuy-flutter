import 'package:roasters/features/auth/domain/entities/user_entity.dart';

class AuthEntity {
  final User user;
  final String accessToken;

  const AuthEntity({
    required this.user,
    required this.accessToken,
  });
}
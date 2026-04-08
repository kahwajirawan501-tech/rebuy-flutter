
import 'package:roasters/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });
  Future <String> signup({
    required String name,
    required String role,
    required String phone,
    required String email,
    required String password,
  });
  Future <User> verifyEmail({
    required String email,
    required String code,
  });
  Future<User?> getUser();
}

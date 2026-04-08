import 'package:dio/dio.dart';
import 'package:roasters/core/network/dio_client.dart';
import 'package:roasters/core/network/dio_exception_extension.dart';
import 'package:roasters/features/auth/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });

  Future<String> signUp({
    required String name,
    required String role,
    required String phone,
    required String email,
    required String password,
  });

  Future<AuthModel> verifyEmail({
    required String email,
    required String code,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/auth/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<String> signUp({
    required String name,
    required String role,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/auth/signup",
        data: {
          "name": name,
          "role": role,
          "phone": phone,
          "email": email,
          "password": password,
        },
      );

      return response.data["message"];
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

  @override
  Future<AuthModel> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await dio.post(
        "/auth/verify-email",
        data: {
          "email": email,
          "code": code,
        },
      );

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.friendlyMessage);
    }
  }

}
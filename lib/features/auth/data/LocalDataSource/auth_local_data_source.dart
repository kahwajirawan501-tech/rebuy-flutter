import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:roasters/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<int?> getIdUser();
  Future<String?> getEmail();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'access_token');
  }
  @override

  Future<int?> getIdUser() async {
    final user = await getUser();
    return user?.id;
  }
  @override

  Future<String?> getEmail() async {
    final user = await getUser();
    return user?.email;
  }
  @override
  Future<void> clearToken() async {
    await storage.delete(key: 'access_token');
  }
  @override
  Future<void> saveUser(UserModel user) async {
    await storage.write(
      key: 'user',
      value: jsonEncode(user.toJson()),
    );

  }

  @override
  Future<UserModel?> getUser() async {
    final data = await storage.read(key: 'user');

    if (data == null) return null;

    return UserModel.fromJson(jsonDecode(data));
  }
  @override

  Future<void> clear() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'user');
  }
}
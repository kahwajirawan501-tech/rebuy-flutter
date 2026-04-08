import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:roasters/features/auth/data/mappers/user_mapper.dart';
import 'package:roasters/features/auth/domain/entities/user_entity.dart';
import 'package:roasters/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl(this.remoteDataSource,this.localDataSource);

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.login(
      email: email,
      password: password,
    );
    await localDataSource.clear();
    await localDataSource.saveToken(model.accessToken);
    await localDataSource.saveUser(model.user);

    return model.user.toEntity();
  }

  @override
  Future<String> signup({
    required String name,
    required String role,
    required String phone,
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.signUp(
      name: name,
      role: role,
      phone: phone,
      email: email,
      password: password,
    );

    return response;
  }

  @override
  Future<User> verifyEmail({
    required String email,
    required String code,
  }) async {
    final model = await remoteDataSource.verifyEmail(
      email: email,
      code: code,
    );
    await localDataSource.clear();
    await localDataSource.saveToken(model.accessToken);
    await localDataSource.saveUser(model.user);
    return model.user.toEntity();
  }

  @override
  Future<User?> getUser() async {
    final model = await localDataSource.getUser();
    return model?.toEntity();
  }
}

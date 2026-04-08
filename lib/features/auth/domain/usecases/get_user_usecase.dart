import 'package:roasters/features/auth/domain/entities/user_entity.dart';
import 'package:roasters/features/auth/domain/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase(this.repository);

  Future<User?> call() async {
    return await repository.getUser();
  }
}
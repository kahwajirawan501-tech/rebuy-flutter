
import '../repositories/auth_repository.dart';

class SignupUseCase{
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future call({
    required String name,
    required String role,
    required String phone,
    required String email,
    required String password,
  }) {
    return repository.signup(
      name:name ,
      phone:phone ,
      role: role,
      email: email,
      password: password,
    );
  }
}

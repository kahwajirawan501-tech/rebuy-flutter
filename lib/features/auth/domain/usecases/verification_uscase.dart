
import '../repositories/auth_repository.dart';

class VerificationUsCase{
  final AuthRepository repository;

  VerificationUsCase(this.repository);

  Future call({
    required String email,
    required String code,
  }) {
    return repository.verifyEmail(

      email: email,
      code: code,
    );
  }
}

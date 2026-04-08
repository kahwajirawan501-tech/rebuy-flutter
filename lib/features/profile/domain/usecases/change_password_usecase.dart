import 'package:roasters/features/profile/domain/repositories/profile_repository.dart';

class ChangePasswordUseCase {
  final ProfileRepository profileRepository;

  ChangePasswordUseCase(this.profileRepository);
  Future<String>call( {required String email,required
  String oldPassword,required String newPassword})async{
    return profileRepository.changePassword(email: email, oldPassword: oldPassword, newPassword: newPassword);
  }
}
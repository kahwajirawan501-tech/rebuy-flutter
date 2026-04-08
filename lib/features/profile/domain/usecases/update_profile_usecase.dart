import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';
import 'package:roasters/features/profile/domain/entities/user_profile_entity.dart';
import 'package:roasters/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase(this.profileRepository);
  Future<UserProfileEntity>call( {required UpdateProfileEntity product})async{
    return profileRepository.updateProfile(product: product);
  }
}
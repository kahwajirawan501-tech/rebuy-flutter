import 'package:roasters/features/auth/data/LocalDataSource/auth_local_data_source.dart';
import 'package:roasters/features/profile/domain/entities/update_profile_entity.dart';

class UpdateProfileBuilder {
  static Future<UpdateProfileEntity> build({
    required AuthLocalDataSource old,
    required UpdateProfileEntity current,
    required String? newImage,
  }) async {
    final user = await old.getUser();

    return UpdateProfileEntity(
      name: current.name != user?.name ? current.name : null,
      phone: current.phone != user?.phone ? current.phone : null,
      image: (newImage != null && newImage.isNotEmpty)
          ? newImage
          :newImage!= user?.profileImage?newImage:null,
    );
  }
}
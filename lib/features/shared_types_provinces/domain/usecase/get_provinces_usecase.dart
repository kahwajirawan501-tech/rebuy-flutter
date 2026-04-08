import 'package:roasters/features/shared_types_provinces/domain/entities/provinces_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/repositories/shared_repository.dart';

class GetProvincesUseCase {
  final SharedRepository sharedRepository;

  GetProvincesUseCase(this.sharedRepository);
  Future<List<ProvincesEntity>>call()async{
    return await sharedRepository.getProvinces();
  }
}
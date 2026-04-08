import 'package:roasters/features/shared_types_provinces/domain/entities/provinces_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/repositories/shared_repository.dart';

class GetTypesUseCase {
  final SharedRepository sharedRepository;

  GetTypesUseCase(this.sharedRepository);
  Future<List<TypesEntity>>call()async{
    return await sharedRepository.getTypes();
  }
}
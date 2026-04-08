import 'package:roasters/features/shared_types_provinces/domain/entities/provinces_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';

abstract class SharedRepository {
  Future<List<TypesEntity>>getTypes();
  Future<List<ProvincesEntity>>getProvinces();
}
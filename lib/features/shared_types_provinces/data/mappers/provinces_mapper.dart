import 'package:roasters/features/shared_types_provinces/data/models/provinces_model.dart';
import 'package:roasters/features/shared_types_provinces/data/models/types_model.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/provinces_entity.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';

extension ProvincesMapper on ProvincesModel{
  ProvincesEntity toEntity(){
    return ProvincesEntity(id: id, name: name);
  }
}
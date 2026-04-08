import 'package:roasters/features/shared_types_provinces/data/models/types_model.dart';
import 'package:roasters/features/shared_types_provinces/domain/entities/types_entity.dart';

extension TypesMapper on TypesModel{
  TypesEntity toEntity(){
    return TypesEntity(id: id, name: name);
  }
}
import 'package:roasters/features/search/data/models/type_search_model.dart';
import 'package:roasters/features/search/domain/entities/type_search_entity.dart';

extension TypeSearchMapper on TypeSearchModel{
  TypeSearchEntity toEntity(){
    return TypeSearchEntity(id: id, name: name);
  }
}
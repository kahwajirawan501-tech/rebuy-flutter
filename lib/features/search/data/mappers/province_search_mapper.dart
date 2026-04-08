import 'package:roasters/features/search/data/models/province_search_model.dart';
import 'package:roasters/features/search/domain/entities/province_search_entity.dart';

extension ProvinceSearchMapper on ProvinceSearchModel{
  ProvinceSearchEntity toEntity(){
    return ProvinceSearchEntity(id: id, name: name);
  }
}
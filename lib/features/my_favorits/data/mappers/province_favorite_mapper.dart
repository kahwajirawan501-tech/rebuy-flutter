
import 'package:roasters/features/my_favorits/data/models/province_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/province_favorite_entity.dart';

extension ProvinceFavoriteMapper on ProvinceFavoriteModel{
  ProvinceFavoriteEntity toEntity(){
    return ProvinceFavoriteEntity(id: id, name: name);
  }
}
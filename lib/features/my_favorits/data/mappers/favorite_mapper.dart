

import 'package:roasters/features/my_favorits/data/models/favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/favorite_entity.dart';
import 'package:roasters/features/my_favorits/data/mappers/product_favorite_mapper.dart';

extension FavoriteMapper on  FavoriteModel{
  FavoriteEntity toEntity(){
    return FavoriteEntity(
        id: id,
        user_id: user_id,
        product_id: product_id,
        product:product.toEntity());
  }
}
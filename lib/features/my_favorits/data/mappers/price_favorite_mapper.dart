import 'package:roasters/features/my_favorits/data/models/price_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/price_favorite_entity.dart';


extension PriceFavoriteMapper on PriceFavoriteModel{
  PriceFavoriteEntity toEntity(){
    return PriceFavoriteEntity(id: id, price: price, type: type);
  }
}
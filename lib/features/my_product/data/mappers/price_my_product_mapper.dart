import 'package:roasters/features/my_favorits/data/models/price_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/price_favorite_entity.dart';
import 'package:roasters/features/my_product/data/models/price_my_product_model.dart';
import 'package:roasters/features/my_product/domain/entities/price_my_product_entity.dart';


extension PriceMyProductMapper on PriceMyProductModel{
  PriceMyProductEntity toEntity(){
    return PriceMyProductEntity(id: id, price: price, type: type);
  }
}
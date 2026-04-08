import 'package:roasters/features/search/data/models/price_search_model.dart';
import 'package:roasters/features/search/domain/entities/price_search_entity.dart';

extension PriceSearchMapper on PriceSearchModel{
  PriceSearchEntity toEntity(){
    return PriceSearchEntity(id: id, price: price, type: type);
  }
}
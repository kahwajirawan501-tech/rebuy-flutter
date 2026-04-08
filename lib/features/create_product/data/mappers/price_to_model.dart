import 'package:roasters/features/create_product/data/models/price_model.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';

extension PriceToModelMapper on PriceEntity {
  PriceModel toModel() {
    return PriceModel(
      price: price,
      type: type,
    );
  }
}
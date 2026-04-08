import 'package:roasters/features/create_product/data/models/contact_model.dart';
import 'package:roasters/features/create_product/data/models/create_product_request.dart';
import 'package:roasters/features/create_product/data/models/price_model.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';

extension ProductToModelMapper on ProductEntity {
  CreateProductRequestModel toModel() {
    return CreateProductRequestModel()
      ..description = description
      ..price = price != null ? PriceModel(type: price!.type, price: price!.price) : null
      ..provinceId = provinceId
      ..addressText = addressText
      ..typeId = typeId
      ..images = images
      ..contacts = contacts
          .map((e) => ContactModel(type: e.type, number: e.number))
          .toList();
  }
}
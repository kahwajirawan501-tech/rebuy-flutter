import 'package:roasters/features/create_product/data/models/create_product_request.dart';
import 'package:roasters/features/create_product/domain/entities/contact_entity.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/domain/entities/product_entity.dart';

extension CreateProductMapper on CreateProductRequestModel {
  ProductEntity toEntity() {
    return ProductEntity(
      description: description ?? "",
      price:PriceEntity(type: price!.type, price: price!.price) ,
      provinceId: provinceId ?? 0,
      addressText: addressText ?? "",
      typeId: typeId ?? 0,
      images: images,
      contacts: contacts.map((e) => ContactEntity(
        type: e.type,
        number: e.number,
      )).toList(),
    );
  }
}
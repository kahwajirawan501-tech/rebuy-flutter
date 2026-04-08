import 'package:roasters/features/create_product/data/mappers/contacts_to_model.dart';
import 'package:roasters/features/create_product/data/mappers/price_to_model.dart';
import 'package:roasters/features/create_product/data/models/update_product_request_model.dart';
import 'package:roasters/features/create_product/domain/entities/price_entity.dart';
import 'package:roasters/features/create_product/domain/entities/update_produc_entity.dart';

extension UpdateProductMapper on UpdateProductEntity {
  UpdateProductRequestModel toModel() {
    return UpdateProductRequestModel(
      description: description,
      price:price?.toModel() ,
      provinceId: provinceId,
      addressText: addressText,
      typeId: typeId,
      images: images,
      contacts: contacts?.map((e) => e.toModel()).toList(),
    );
  }
}
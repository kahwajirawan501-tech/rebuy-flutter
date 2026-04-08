

import 'package:roasters/features/my_product/data/mappers/price_my_product_mapper.dart';
import 'package:roasters/features/my_product/data/mappers/province_my_product_mapper.dart';
import 'package:roasters/features/my_product/data/mappers/type_my_product_mapper.dart';
import 'package:roasters/features/my_product/data/models/product_my_product_model.dart';
import 'package:roasters/features/my_product/domain/entities/contact_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/image_my_product_entity.dart';
import 'package:roasters/features/my_product/domain/entities/product_my_product_entity.dart';

extension ProductMyProductMapper on ProductMyProductModel{
  ProductMyProductEntity toEntity(){
    return ProductMyProductEntity
      (id: id,
        description: description,
        isSold: isSold,
        userId: userId,
        provinceId: provinceId,
        addressText: addressText,
        typeId: typeId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        images: images.map((e)=>ImageMyProductEntity(id: e.id, imageUrl: e.imageUrl)).toList(),
        contacts: contacts.map((e) => ContactMyProductEntity(
          id: e.id,
          type: e.type,
          number: e.number,
        )).toList(),
        province: province.toEntity(),
        type: type.toEntity(),
        price: price?.toEntity(),
        isFavorite: isFavorite);
  }
}
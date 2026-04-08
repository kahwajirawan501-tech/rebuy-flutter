import 'package:roasters/features/search/data/mappers/price_search_mapper.dart';
import 'package:roasters/features/search/data/mappers/province_search_mapper.dart';
import 'package:roasters/features/search/data/mappers/seller_mapper.dart';
import 'package:roasters/features/search/data/mappers/type_search_mapper.dart';
import 'package:roasters/features/search/data/models/product_search_model.dart';
import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:roasters/features/search/domain/entities/image_search_entity.dart';
import 'package:roasters/features/search/domain/entities/product_search_entity.dart';

extension ProductSearchMapper on ProductSearchModel{
  ProductSearchEntity toEntity(){
    return ProductSearchEntity
      (id: id,
        description: description,
        isSold: isSold,
        userId: userId,
        provinceId: provinceId,
        addressText: addressText,
        typeId: typeId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        images: images.map((e)=>ImageSearchEntity(id: e.id, imageUrl: e.imageUrl)).toList(),
        contacts: contacts.map((e) => ContactSearchEntity(
          id: e.id,
          type: e.type,
          number: e.number,
        )).toList(),
        province: province.toEntity(),
        type: type.toEntity(),
        price: price?.toEntity(),
        user: user.toEntity(),
        isFavorite: isFavorite);
  }
}
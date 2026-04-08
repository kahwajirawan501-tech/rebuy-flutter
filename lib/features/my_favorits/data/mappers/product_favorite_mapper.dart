import 'package:roasters/features/my_favorits/data/mappers/price_favorite_mapper.dart';
import 'package:roasters/features/my_favorits/data/mappers/province_favorite_mapper.dart';
import 'package:roasters/features/my_favorits/data/mappers/seller_mapper.dart';
import 'package:roasters/features/my_favorits/data/mappers/type_favorite_mapper.dart';
import 'package:roasters/features/my_favorits/data/models/product_favorite_model.dart';
import 'package:roasters/features/my_favorits/domain/entities/contact_favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/image_favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/product_favorite_entity.dart';


extension ProductFavoriteMapper on ProductFavoriteModel{
  ProductFavoriteEntity toEntity(){
    return ProductFavoriteEntity
      (id: id,
        description: description,
        isSold: isSold,
        userId: userId,
        provinceId: provinceId,
        addressText: addressText,
        typeId: typeId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        images: images.map((e)=>ImageFavoriteEntity(id: e.id, imageUrl: e.imageUrl)).toList(),
        contacts: contacts.map((e) => ContactFavoriteEntity(
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
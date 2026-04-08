
import 'package:roasters/features/my_favorits/domain/entities/contact_favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/image_favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/price_favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/province_favorite_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/seller_entity.dart';
import 'package:roasters/features/my_favorits/domain/entities/type_favorite_entity.dart';

class ProductFavoriteEntity {
  final int id;
  final String description;
  final bool isSold;
  final int userId;
  final int provinceId;
  final String addressText;
  final int typeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SellerFavoriteEntity user;
  final List<ImageFavoriteEntity> images;
  final List<ContactFavoriteEntity> contacts;
  final ProvinceFavoriteEntity province;
  final TypeFavoriteEntity type;
  final PriceFavoriteEntity? price;
  final bool isFavorite;

  ProductFavoriteEntity({
    required this.id,
    required this.description,
    required this.isSold,
    required this.userId,
    required this.provinceId,
    required this.addressText,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.contacts,
    required this.province,
    required this.type,
    required this.price,
    required this.isFavorite,
    required this.user,
  });

  ProductFavoriteEntity copyWith({
    int? id,
    String? description,
    bool? isSold,
    int? userId,
    int? provinceId,
    String? addressText,
    int? typeId,
    DateTime? createdAt,
    DateTime? updatedAt,
    SellerFavoriteEntity? user,
    List<ImageFavoriteEntity>? images,
    List<ContactFavoriteEntity>? contacts,
    ProvinceFavoriteEntity? province,
    TypeFavoriteEntity? type,
    PriceFavoriteEntity? price,
    bool? isFavorite,
  }) {
    return ProductFavoriteEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      isSold: isSold ?? this.isSold,
      userId: userId ?? this.userId,
      provinceId: provinceId ?? this.provinceId,
      addressText: addressText ?? this.addressText,
      typeId: typeId ?? this.typeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      images: images ?? this.images,
      contacts: contacts ?? this.contacts,
      province: province ?? this.province,
      type: type ?? this.type,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}